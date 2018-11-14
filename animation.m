clc;clear;close all;
alpha=[0,0]
a=[5 6]
d=[0,0]
theta=zeros(1,2);
dh=[theta' d' a' alpha'];
for i=1:2
L2{i}=Link('d',dh(i,2),'a',dh(i,3),'alpha',dh(i,4));

end
figure(1);
R2=SerialLink([L2{1} L2{2}])
theta1=[ 1.5708    1.5690    1.5653    1.5599    1.5512    1.5396    1.5265    1.5132    1.4994    1.4844    1.4687    1.4530 1.4378    1.4234    1.4093    1.3963];
theta2=[  0    0.0034    0.0078    0.0132    0.0246    0.0412    0.0591    0.0744    0.0886    0.1045    0.1209    0.1362 0.1488    0.1588    0.1679    0.1745];
qd=[theta1;theta2]'
W=[-5 15 -5 15 -10 10];
R2.plot(qd,'top','loop','workspace',W)
% teach(R2)