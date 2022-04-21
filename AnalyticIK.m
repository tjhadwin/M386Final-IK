clear all; clc;

syms L_1 L_2 theta_1 theta_2 XE YE

XE_RHS = L_1*cos(theta_1) + L_2*cos(theta_1+theta_2);
YE_RHS = L_1*sin(theta_1) + L_2*sin(theta_1+theta_2);

XE_MLF = matlabFunction(XE_RHS,'vars',[L_1 L_2 theta_1 theta_2]);
YE_MLF = matlabFunction(YE_RHS,'vars',[L_1 L_2 theta_1 theta_2]);

t1_degs_row = linspace(0,90,100);
t2_degs_row = linspace(-180,180,100);
[tt1_degs,tt2_degs] = meshgrid(t1_degs_row,t2_degs_row);

tt1_rads = deg2rad(tt1_degs);
tt2_rads = deg2rad(tt2_degs);

X_mat = XE_MLF(L_1,L_2,tt1_rads,tt2_rads);
Y_mat = YE_MLF(L_1,L_2,tt1_rads,tt2_rads);

XE_EQ = XE == XE_RHS;
YE_EQ = YE == YE_RHS;

S = solve([XE_EQ YE_EQ], [theta_1 theta_2]);

simplify(S.theta_1)
simplify(S.theta_2)

TH1_MLF{1} = matlabFunction(S.theta_1(1),'Vars',[L_1 L_2 XE YE]);
TH1_MLF{2} = matlabFunction(S.theta_1(2),'Vars',[L_1 L_2 XE YE]);
TH2_MLF{1} = matlabFunction(S.theta_2(1),'Vars',[L_1 L_2 XE YE]);
TH2_MLF{2} = matlabFunction(S.theta_2(2),'Vars',[L_1 L_2 XE YE]);

[xmat,ymat] = meshgrid(0:0.01:1.5,0:0.01:1.5);

tmp_th1_mat = TH1_MLF{1}(L_1,L_2,xmat,ymat);
tmp_th2_mat = TH2_MLF{1}(L_1,L_2,xmat,ymat);

tmp_th1_mat = rad2deg(tmp_th1_mat);
tmp_th2_mat = rad2deg(tmp_th2_mat);

th1_mat = NaN(size(tmp_th1_mat));
th2_mat = NaN(size(tmp_th2_mat));

tf_mat = imag(tmp_th1_mat) == 0;
th1_mat(tf_mat) = real(tmp_th1_mat(tf_mat));

tf_mat = imag(tmp_th2_mat) == 0;
th2_mat(tf_mat) = real(tmp_th2_mat(tf_mat));

L_1 = 1; L_2 = .5;

plot_XY_given_theta_2dof(tt1_degs,tt2_degs,X_mat,Y_mat,L_1+L_2)
plot_theta_given_XY_2dof(xmat,ymat,th1_mat,th2_mat)