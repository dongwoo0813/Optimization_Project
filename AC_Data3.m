%
% Aircraft Dimensional Derivatives
% Reference: Yechout, Appendix H
%
% 01/06/11 KAB  Added Cases 24 to 28 from Flight Stability and Automatic
%               Control, Robert C. Nelson, 1989
% 01/06/11 KAB  Added Cases 29 to 36 from Aircraft Dynamics and Automatic
%               Control, Duane McRuer, 1968
% 01/06/11 KAB  Added Case 37 as an example of data from a Project 1 Glider
%
% 04/07/13 KAB  Added Cases 37-45 from Aircraft Dynamics from Modeling to
%               Simulation, Marcello R. Napolitano and renumber glider as
%               Case 46
%
% Define Constants
% AC = 1;
g=32.174; %acceleration due to gravity, ft/s2
d2r=pi/180; %degrees to radians
r2d=180/pi; %radians to degrees
fps2kt=0.5924838013;    %feet/second to knots
%No data given, assume zero for all cases
Xtu=0; %X-Thrust Force/airspeed
Zadt=0; %Z-Force/alpha dot
Zq=0; %Z-force/pitch rate
Mtu=0; %Thrust Pitch Moment/airspeed
Mta=0; %Thrust Pitch Moment/alpha
Yp=0; %Y-force/roll rate
Yr=0; %Y-force/yaw rate
Ntb=0; %Thrust Yaw Moment/beta

% Define Cases, AC:

%%%% Below here from AE413 Project 1  %%%%%

switch AC
    case{1}
    % Data for AC+U1:X43_Data3 for Project 1			
    AC_ID	=	'Glider'	;
    Alt	=	5006	; %ft
    M	=	0.022792	; %Mach Number
    U1	=	25.000000	; %ft/s
    rho	=	0.002048	; %slug/ft3
    qbar	=	0.640000	; %lb/ft2
    Wt	=	0.066011	; %lb
    S	=	0.375000	; %ft2
    b	=	1.500000	; %ft
    cbar	=	0.250000	; %ft
    Xbarcg	=	2.101852	;
    tht	=	-0.086588	; %rad
    atrm	=	0.077931	; %rad
    Ixx	=	0.000131	; %slug-ft2
    Iyy	=	0.000284	; %slug-ft2
    Izz	=	0.000410	; %slug-ft2
    Ixz	=	0.000013	; %slug-ft2
    X0	=	[U1 atrm 0 tht 0 0 0 0]'	; 
    Xu	=	-0.427322	; %1/s
    Xa	=	-32.174000	; %ft/s2
    Zu	=	-2.574589	; %1/s
    Za	=	-420.482157	; %ft/s2
    Mu	=	0.000000	; %1/ft-s
    Ma	=	-21.934064	; %1/s2
    Madt	=	-1.295512	; %1/s
    Mq	=	-4.187233	;%1/s
    Xde	=	0	;%ft/s2
    Zde	=	0	; %ft/s2
    Mde	=	0	; %1/s2
    Yb	=	-17.470489	; %ft/s2
    Lb	=	-273.444689	; %1/s2
    Lp	=	-47.632530	; %1/s
    Lr	=	8.052558	; %1/s
    Nb	=	81.363337	; %1/s2
    Np	=	-1.461778	; %1/s
    Nr	=	-3.284061	; %1/s
    Ydr	=	0	; %ft/s2
    Ldr	=	0	; %1/s2
    Ndr	=	0	; %1/s2
    Yda	=	0	; %ft/s2
    Lda	=	0	; %1/s2
    Nda	=	0	; %1/s2

end