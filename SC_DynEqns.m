% Define Aircraft Constants
% AC=3; % Select Aircraft
AC_Data3 % Call M-file to define dimensional coefficients 


mass=Wt/g;

% Note: Aircraft Cases, AC

%%%% Below here from AE413 Project 1  %%%%%
% 46 = Balsa Glider at 5k ft M=0.02, trimmed in glide
%
% Create State-Space Matrices from Dimensional Derivatives
%   Longitudinal States: u (ft/s), alpha (rad), q (rad/s), theta (rad)
%   Lateral-Directional States: beta (rad), p (rad/s), r (rad/s), phi (rad)
%
w2a=1/(U1-Zadt); %Used to change w-row to alpha-row
% Longitudinal
Along=[Xu+Xtu Xa 0 -g*cos(tht)
    Zu*w2a Za*w2a (U1+Zq)*w2a -g*sin(tht)*w2a
    Mu+Mtu+Madt*Zu*w2a Ma+Mta+Madt*Za*w2a Mq+Madt*(U1+Zq)*w2a -Madt*g*sin(tht)*w2a
    0 0 1 0];
Blong=[Xde;Zde*w2a;Mde+Madt*Zde*w2a;0];
% Lateral-Driectional
Ald=[Yb/U1 Yp/U1 (Yr/U1)-1 g*cos(tht)/U1
    Lb Lp Lr 0
    Nb+Ntb Np Nr 0
%     0 1 tan(tht) 0];
    0 1 0 0];
Bld=[Yda/U1 Ydr/U1
    Lda Ldr
    Nda Ndr
    0 0];
% Include coupling terms
A1=Ixz/Ixx;
B1=Ixz/Izz;
Mpr=[1 -A1;-B1 1];
Mpri=inv(Mpr);
Ald(2:3,:)=Mpri*Ald(2:3,:);
Bld(2:3,:)=Mpri*Bld(2:3,:);
% Combine Longitudinal and Lateral-Directional
A=[Along zeros(4,4);zeros(4,4) Ald];
B=[Blong,zeros(4,2);zeros(4,1),Bld];
% Define Gain Matrix
K=zeros(4,8);
% Add Throttle to Control Matrix
B=[B,[1;0;0;0;0;0;0;0]];
%
% Estimates of Roots from Dimensional Derivatives
%
wn_sp=sqrt((Za*Mq/U1)-Ma); %short period natural frequency, EQ7.35 p.335
z_sp=-(Mq+Madt+(Za/U1))/(2*wn_sp); %short period damping, EQ7.36 p.335
wn_ph=sqrt(2)*g/U1; %phugoid natural frequency, EQ7.40 p.337
z_ph=-(Xu+Xtu)/(2*wn_ph); %phugoid damping, p 337 (typo on page)
tau_r=-1/Lp; %roll mode time constant, EQ7.51 p.348
tau_sp=(Lb+Nb*(Ixz/Ixx))/(Nb*Lr-Lb*Nr); %spiral mode time constant, EQ7.54 p 351
Cnb=Nb*Izz/(qbar*S*b);
Cnr=2*Nr*Izz*U1/(qbar*S*b*b);
wn_dr1=sqrt((S*b*Cnb*rho)/(2*Izz))*U1; %dutch-roll natural frequency, EQ7.56 p 351
z_dr1=-sqrt((2*S*(b^3)*rho)/(Izz*Cnb))*Cnr/8; %dutch-roll damping, EQ7.56 p351
wn_dr2=sqrt((Yb*Nr-Nb*Yr+U1*Nb)/U1); %dutch-roll natural frequency, EQ7.57 p 352
z_dr2=-(Yb+U1*Nr)/(2*U1*wn_dr2); %dutch-roll damping, EQ7.57 p 352
wn_dr3=sqrt(g*Lb/(U1*Lp)); %dutch-roll natural frequency, EQ7.58 p 353
% z_dr3=-(Yb/U1)*sqrt(U1*Lp/(g*Lb)); %dutch-roll damping, EQ7.58 p 353 %Error in Yechout...should be
z_dr3=-(Yb/(2*U1))*sqrt(U1*Lp/(g*Lb)); %dutch-roll damping, EQ7.58 p 353
%
% Full Transfer Functions from Dimensional Derivatives
% Reference: Yechout, Appendix G
%
%Longitudinal Denominator
ELG=U1-Zadt;
FLG=-(U1-Zadt)*(Xu+Xtu+Mq)-Za-Madt*(U1+Zq);
GLG=(Xu+Xtu)*(Mq*(U1-Zadt)+Za+Madt*(U1+Zq))+Mq*Za-Zu*Xa+Madt*g*sin(tht)...
    -(Ma+Mta)*(U1+Zq);
% HLG=g*sin(tht)*(Ma+Mtu-Madt*(Xu+Xtu))+g*cos(tht)*(Zu*Madt+...
%     (Mu+Mtu)*(U1-Zadt))+(Mu+Mtu)*(-Xa*(U1+Zq))+Zu*Xa*Mq...
%     +(Xu+Xtu)*((Ma+Mtu)*(U1+Zq)-Mq*Za); %Error in Yechout...should be
HLG=g*sin(tht)*(Ma+Mta-Madt*(Xu+Xtu))+g*cos(tht)*(Zu*Madt+...
    (Mu+Mtu)*(U1-Zadt))+(Mu+Mtu)*(-Xa*(U1+Zq))+Zu*Xa*Mq...
    +(Xu+Xtu)*((Ma+Mta)*(U1+Zq)-Mq*Za);
ILG=g*cos(tht)*((Ma+Mta)*Zu-Za*(Mu+Mtu))+...
    g*sin(tht)*((Mu+Mtu)*Xa-(Xu+Xtu)*(Ma+Mta));
DenLG=[ELG FLG GLG HLG ILG]; %Longitudinal Denominator
%Lateral-Directional Denominator
ELD=U1*(1-A1*B1);
% FLD=-Yb-(1-A1*B1)-U1*(Lp+Nr+A1*Np+B1*Lr);  %Error in Yechout...should be
FLD=-Yb*(1-A1*B1)-U1*(Lp+Nr+A1*Np+B1*Lr);
GLD=U1*(Lp*Nr-Lr*Np)+Yb*(Nr+Lp+A1*Np+B1*Lr)-Yp*(Lb+Nb*A1+Ntb*A1)+...
    U1*(Lb*B1+Nb+Ntb)-Yr*(Lb*B1+Nb+Ntb);
HLD=-Yb*(Lp*Nr-Lr*Np)+Yp*(Lb*Nr-Nb*Lr-Ntb*Lr)-g*cos(tht)*(Lb+Nb*A1+Ntb*A1)...
    +U1*(Lb*Np-Nb*Lp-Ntb*Lp)-Yr*(Lb*Np-Nb*Lp-Ntb*Lp);
ILD=g*cos(tht)*(Lb*Nr-Nb*Lr-Ntb*Lr);
DenLD=[ELD FLD GLD HLD ILD 0]; %Lateral-Directional Denominator
% Velocity/Elevator Numerator
Au=Xde*(U1-Zadt);
Bu=-Xde*((U1-Zadt)*Mq+Za+Madt*(U1+Zq))+Zde*Xa;
% Cu=Xde*(Mq*Za+Madt*g*sin(tht)-Ma*Mta*(U1+Zq))+Zde*(Madt*g*cos(tht)-Xa*Mq)...
%     +Mde*(Xa*(U1+Zq)-(U1-Zadt)*g*cos(tht)); %Error in Yechout...should be
Cu=Xde*(Mq*Za+Madt*g*sin(tht)-(Ma+Mta)*(U1+Zq))+Zde*(-Madt*g*cos(tht)-Xa*Mq)...
    +Mde*(Xa*(U1+Zq)-(U1-Zadt)*g*cos(tht)); 
% Du=Xde*(Ma+Mta)*g*sin(tht)-Zde*Ma*g*cos(tht)*Mde*(Za*g*cos(tht)-...
%     Xa*g*sin(tht)); %Error in Yechout...should be
Du=Xde*(Ma+Mta)*g*sin(tht)-Zde*(Ma+Mta)*g*cos(tht)+Mde*(Za*g*cos(tht)-...
    Xa*g*sin(tht)); 
Numu=[Au Bu Cu Du];
% Alpha/Elevator Numerator
Aa=Zde;
Ba=Xde*Zu+Zde*(-Mq-(Xu+Xtu))+Mde*(U1+Zq);
Ca=Xde*((U1+Zq)*(Mu+Mtu)-Mq*Zu)+Zde*Mq*(Xu+Xtu)+...
    Mde*(-g*sin(tht)-(U1+Zq)*(Xu+Xtu));
Da=-Xde*(Mu+Mtu)*g*sin(tht)+Zde*(Mu+Mtu)*g*cos(tht)+...
    Mde*((Xu+Xtu)*g*sin(tht)-Zu*g*cos(tht));
Numa=[Aa Ba Ca Da];
% Theta/Elevator Numerator
At=Zde*Madt+Mde*(U1-Zadt);
Bt=Xde*(Zu*Madt+(U1-Zadt)*(Mu+Mtu))+Zde*((Ma+Mta)-Madt*(Xu+Xtu))+...
    Mde*(-Za-(U1-Zadt)*(Xu+Xtu));
% Ct=Xde*((Ma+Mtu)*Zu-Za*(Mu+Mtu))+Zde*(-(Ma+Mtu)*(Xu+Xtu)+Xa*(Mu+Mtu))+...
%     Mde*(Za*(Xu+Xtu)-Xa*Zu); %Error in Yechout...should be
Ct=Xde*((Ma+Mta)*Zu-Za*(Mu+Mtu))+Zde*(-(Ma+Mta)*(Xu+Xtu)+Xa*(Mu+Mtu))+...
    Mde*(Za*(Xu+Xtu)-Xa*Zu);
Numt=[At Bt Ct];
% Beta/Aileron Numerator
Aba=Yda*(1-A1*B1);
% Bba=Yda*(Nr+Lp+A1*Np+B1*Lr)+Yp*(Lda+Nda*A1)+Yr*(Lda*B1+Nda)+...
%     -U1*(Lda*B1+Nda); %Error in Yechout...should be
Bba=-Yda*(Nr+Lp+A1*Np+B1*Lr)+Yp*(Lda+Nda*A1)+Yr*(Lda*B1+Nda)+...
    -U1*(Lda*B1+Nda);
Cba=Yda*(Lp*Nr-Np*Lr)+Yp*(Nda*Lr-Lda*Nr)+g*cos(tht)*(Lda+Nda*A1)+...
    Yr*(Lda*Np-Nda*Lp)-U1*(Lda*Np-Nda*Lp);
Dba=g*cos(tht)*(Nda*Lr-Lda*Nr);
Numba=[Aba Bba Cba Dba 0];
% Beta/Rudder Numerator
Abr=Ydr*(1-A1*B1);
% Bbr=Ydr*(Nr+Lp+A1*Np+B1*Lr)+Yp*(Ldr+Ndr*A1)+Yr*(Ldr*B1+Ndr)+...
%     -U1*(Ldr*B1+Ndr); %Error in Yechout...should be
Bbr=-Ydr*(Nr+Lp+A1*Np+B1*Lr)+Yp*(Ldr+Ndr*A1)+Yr*(Ldr*B1+Ndr)+...
    -U1*(Ldr*B1+Ndr);
Cbr=Ydr*(Lp*Nr-Np*Lr)+Yp*(Ndr*Lr-Ldr*Nr)+g*cos(tht)*(Ldr+Ndr*A1)+...
    Yr*(Ldr*Np-Ndr*Lp)-U1*(Ldr*Np-Ndr*Lp);
Dbr=g*cos(tht)*(Ndr*Lr-Ldr*Nr);
Numbr=[Abr Bbr Cbr Dbr 0];
% Phi/Aileron Numerator
Apha=U1*(Lda+Nda*A1);
Bpha=U1*(Nda*Lr-Lda*Nr)-Yb*(Lda+Nda*A1)+Yda*(Lb+Nb*A1+Ntb*A1);
Cpha=-Yb*(Nda*Lr-Lda*Nr)+Yda*(Lr*Nb+Lr*Ntb-Nr*Lb)+...
    (U1-Yr)*(Nb*Lda+Ntb*Lda-Lb*Nda);
Numpha=[Apha Bpha Cpha 0];
% Phi/Rudder Numerator
Aphr=U1*(Ldr+Ndr*A1);
Bphr=U1*(Ndr*Lr-Ldr*Nr)-Yb*(Ldr+Ndr*A1)+Ydr*(Lb+Nb*A1+Ntb*A1);
Cphr=-Yb*(Ndr*Lr-Ldr*Nr)+Ydr*(Lr*Nb+Lr*Ntb-Nr*Lb)+...
    (U1-Yr)*(Nb*Ldr+Ntb*Ldr-Lb*Ndr);
Numphr=[Aphr Bphr Cphr 0];
% Psi/Aileron Numerator
Apsa=U1*(Nda+Lda*B1);
Bpsa=U1*(Lda*Np-Nda*Lp)-Yb*(Nda+Lda*B1)+Yda*(Lb*B1+Nb+Ntb);
Cpsa=-Yb*(Lda*Np-Nda*Lp)+Yp*(Nb*Lda+Ntb*Lda-Lb*Nda)+...
    Yda*(Lb*Np-Nb*Lp-Ntb*Lp);
Dpsa=g*cos(tht)*(Nb*Lda+Ntb*Lda-Lb*Nda);
Numpsa=[Apsa Bpsa Cpsa Dpsa];
% Psi/Rudder Numerator
Apsr=U1*(Ndr+Ldr*B1);
Bpsr=U1*(Ldr*Np-Ndr*Lp)-Yb*(Ndr+Ldr*B1)+Ydr*(Lb*B1+Nb+Ntb);
Cpsr=-Yb*(Ldr*Np-Ndr*Lp)+Yp*(Nb*Ldr+Ntb*Ldr-Lb*Ndr)+...
    Ydr*(Lb*Np-Nb*Lp-Ntb*Lp);
Dpsr=g*cos(tht)*(Nb*Ldr+Ntb*Ldr-Lb*Ndr);
Numpsr=[Apsr Bpsr Cpsr Dpsr];
% Short period Alpha Transfer Function approximation (EQ 7.34 page 335)
NumA=[Zde (Mde*U1-Mq*Zde)];
DenA=[U1 -(Mq*U1+Za+Madt*U1) (Za*Mq-(Ma*U1))];
% Short period Theta Transfer Function approximation (EQ 7.34 page 335)
NumT=[(Mde*U1+Madt*Zde) (Ma*Zde-Za*Mde)];
DenT=[U1 -(Mq*U1+Za+Madt*U1) (Za*Mq-(Ma*U1)) 0];