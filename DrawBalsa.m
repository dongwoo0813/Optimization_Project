% Data for DrawBalsa					

b = INPUTS(2,1);          %  Wing span	,	in
cr = INPUTS(3,1);         %	Wing Chord (root)	,	in
ct = INPUTS(4,1);        %	Wing Chord (tip)	,	in
Gam = INPUTS(5,1);        %	Dihedral	,	deg
LamLE = INPUTS(6,1);      %	LE_Sweep	,	deg
iw = INPUTS(7,1);         %	iw	,	deg
bH = INPUTS(9,1);         %	HT Span	,	in
crH = INPUTS(10,1);       %	HT Chord (root)	,	in
ctH = INPUTS(11,1);       %	HT Chord (tip)	,	in
GamH = INPUTS(12,1);      %	Dihedral_h	,	deg
LamLEH = INPUTS(13,1);	 %	Sweep_h_LE	,	deg
Vtrim = INPUTS(1,1);      %	Vtrim	,	ft/s
bV = INPUTS(15,1);	     %	VT height	,	in
crV = INPUTS(16,1);     	 %	VT Chord (root)	,	in
ctV = INPUTS(17,1);       %	VT Chord (tip)	,	in
LamLEV = INPUTS(18,1);  	 %	Sweep_v_LE	,	deg
x_W_LE = INPUTS(8,1);	 %	x_wing_LE	, 	in
x_H_LE = INPUTS(14,1);	 %	x_HT_LE	,	in
x_V_LE = INPUTS(19,1);	 %	x_VT_LE	,	in
z_HT = INPUTS(20,1);      %	z_HT	,	in
FL = INPUTS(21,1); 	%	Fuselage Length	,	in
FH = INPUTS(22,1);	%	Fuselage Height	,	in
FW = INPUTS(23,1);	%	Fuselage Width	,	in
x_B = INPUTS(24,1);	%	x_ballast	,	in
wt_B = INPUTS(25,1);	%	wt_ballast	,	lb


iH=0;  % horizontal tail incidence angle 0 deg
aa=.2;       % tansperancy [0=see through, 1=solid]
% Set up volume
temp1=plot3([0 18 18],[9 9 -9],[-9 9 9],'*');
hold on
% Draw 6 sides of fuselage
F1=fill3([0 0 FL FL],[FW/2 FW/2 FW/2 FW/2],[-FH/2 FH/2 FH/2 -FH/2],[.6 .4 0]);
alpha(F1,aa);
% hold on
F2=fill3([0 0 FL FL],[-FW/2 -FW/2 -FW/2 -FW/2],[-FH/2 FH/2 FH/2 -FH/2],[.6 .4 0]);
alpha(F2,aa);
F3=fill3([0 0 0 0],[-FW/2 -FW/2 FW/2 FW/2],[-FH/2 FH/2 FH/2 -FH/2],[.6 .4 0]);
alpha(F3,aa);
F4=fill3([FL FL FL FL],[-FW/2 -FW/2 FW/2 FW/2],[-FH/2 FH/2 FH/2 -FH/2],[.6 .4 0]);
alpha(F4,aa);
F5=fill3([0 0 FL FL],[-FW/2 FW/2 FW/2 -FW/2],[FH/2 FH/2 FH/2 FH/2],[.6 .4 0]);
alpha(F5,aa);
F6=fill3([0 0 FL FL],[-FW/2 FW/2 FW/2 -FW/2],[-FH/2 -FH/2 -FH/2 -FH/2],[.6 .4 0]);
alpha(F6,aa);
% Draw Wing
XW1=x_W_LE;
XW2=XW1+(b/2)*tand(LamLE);
XW3=XW2+ct;
XW4=XW1+cr;
XW5=XW3;
XW6=XW2;

YW1=0;
YW2=b/2;
YW3=b/2;
YW4=0;
YW5=-b/2;
YW6=-b/2;

ZW1=FH/2+cr*sind(iw);
ZW2=FH/2+(XW4-XW2)*sind(iw)+(b/2)*tand(Gam);
ZW3=FH/2+(XW4-XW3)*sind(iw)+(b/2)*tand(Gam);
ZW4=FH/2;
ZW5=ZW3;
ZW6=ZW2;

XW=[XW1 XW2 XW3 XW4 XW5 XW6];
YW=[YW1 YW2 YW3 YW4 YW5 YW6];
ZW=[ZW1 ZW2 ZW3 ZW4 ZW5 ZW6];
W1=fill3(XW,YW,ZW,[.6 .4 0]);
alpha(W1,aa);

% Draw Horizontal Tail
XH1=x_H_LE;
XH2=XH1+(bH/2)*tand(LamLEH);
XH3=XH2+ctH;
XH4=XH1+crH;
XH5=XH3;
XH6=XH2;

YH1=0;
YH2=bH/2;
YH3=bH/2;
YH4=0;
YH5=-bH/2;
YH6=-bH/2;

ZH1=FH/2+z_HT+crH*sind(iH);
ZH2=FH/2+z_HT+(XH4-XH2)*sind(iH)+(bH/2)*tand(GamH);
ZH3=FH/2+z_HT+(XH4-XH3)*sind(iH)+(bH/2)*tand(GamH);
ZH4=FH/2+z_HT;
ZH5=ZH3;
ZH6=ZH2;

XH=[XH1 XH2 XH3 XH4 XH5 XH6];
YH=[YH1 YH2 YH3 YH4 YH5 YH6];
ZH=[ZH1 ZH2 ZH3 ZH4 ZH5 ZH6];
H1=fill3(XH,YH,ZH,[.6 .4 0]);
alpha(H1,aa);

% Draw Vertical Tail
XV1=x_V_LE;
XV2=XV1+bV*tand(LamLEV);
XV3=XV2+ctV;
XV4=XV1+crV;

YV1=0;
YV2=0;
YV3=0;
YV4=0;

ZV1=FH/2;
ZV2=FH/2+bV;
ZV3=FH/2+bV;
ZV4=FH/2;

XV=[XV1 XV2 XV3 XV4];
YV=[YV1 YV2 YV3 YV4];
ZV=[ZV1 ZV2 ZV3 ZV4];
V1=fill3(XV,YV,ZV,[.6 .4 0]);
alpha(V1,aa);

% Draw ballast
db=4*min([FH FW])*(wt_B/0.025);
B1=fill3([x_B-db x_B-db x_B+db x_B+db],[FW/2 FW/2 FW/2 FW/2]+db,[-FH/2-db FH/2+db FH/2+db -FH/2-db],[0 0 0]);
alpha(B1,aa);
B2=fill3([x_B-db x_B-db x_B+db x_B+db],[-FW/2 -FW/2 -FW/2 -FW/2]-db,[-FH/2-db FH/2+db FH/2+db -FH/2-db],[0 0 0]);
alpha(B2,aa);
B3=fill3([x_B-db x_B-db x_B-db x_B-db],[-FW/2-db -FW/2-db FW/2+db FW/2+db],[-FH/2-db FH/2+db FH/2+db -FH/2-db],[0 0 0]);
alpha(B3,aa);
% B4=fill3([FL FL FL FL],[-FW/2 -FW/2 FW/2 FW/2],[-FH/2 FH/2 FH/2 -FH/2],[0 0 0]);
% alpha(B4,aa);
B5=fill3([x_B-db x_B-db x_B+db x_B+db],[-FW/2-db FW/2+db FW/2+db -FW/2-db],[FH/2 FH/2 FH/2 FH/2]+db,[0 0 0]);
alpha(B5,aa);
B6=fill3([x_B-db x_B-db x_B+db x_B+db],[-FW/2-db FW/2+db FW/2+db -FW/2-db],[-FH/2 -FH/2 -FH/2 -FH/2]-db,[0 0 0]);
alpha(B6,aa);

axis equal
xlabel('X (in)')
ylabel('Y (in)')
zlabel('Z (in)')
grid on
set(temp1,'Visible','Off')

