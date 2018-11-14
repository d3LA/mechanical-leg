function dx=samplesys(time,x,tau,dt)
%function of the double link system
[B,C,G]=dynamics_matrices([x(1);x(3)],[x(2);x(4)]);
t=floor(time/dt)+1;
dx=zeros(4,1);

%state space
dx(1)=x(2);                            %dtheta1
dx(3)=x(4);                            %ddtheta1
a=B^-1*(tau(t,:)'-G-C*[x(2);x(4)]);    
dx(2)=a(1);                            %dtheta2
dx(4)=a(2);                            %ddtheta2 
% disp(t)
end