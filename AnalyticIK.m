clear all; clc;

syms L_1 L_2 L_3 theta_1 theta_2 theta_3 XE YE ZE
tic;
XE_RHS = L_1*cos(theta_1) + (L_2+L_3*cos(theta_3))*cos(theta_1+theta_2);
YE_RHS = L_1*sin(theta_1) + (L_2+L_3*cos(theta_3))*sin(theta_1+theta_2);
ZE_RHS = L_3*sin(theta_3);

toc;
tic;
XE_EQ = XE == XE_RHS;
YE_EQ = YE == YE_RHS;
ZE_EQ = ZE == ZE_RHS;

S = solve([XE_EQ YE_EQ ZE_EQ], [theta_1 theta_2 theta_3], 'IgnoreAnalyticConstraints',true)

simplify(S.theta_1)
simplify(S.theta_2)
simplify(S.theta_3)

TH1_MLF{1} = matlabFunction(S.theta_1(1),'Vars',[L_1 L_2 L_3 XE YE ZE]);
TH2_MLF{1} = matlabFunction(S.theta_2(1),'Vars',[L_1 L_2 L_3 XE YE ZE]);
TH3_MLF{1} = matlabFunction(S.theta_3(1),'Vars',[L_1 L_2 L_3 XE YE ZE]);

f = @(x,y,z) [rad2deg(TH1_MLF{1}(1,.5,1,x,y,z)) rad2deg(TH2_MLF{1}(1,.5,1,x,y,z)) rad2deg(TH3_MLF{1}(1,.5,1,x,y,z))];

toc;
