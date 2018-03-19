function [ Tx,t1,t2,t3,t4,t5] = Calculate_Tx_EL (i,j,Ex,Ey,Dx,Dy,Hz,Hz_n_prev,Bz,Bz_n_prev,dx,dy )

% T1=-eps_o(t1+t2)+(1/{\mu_o})t3-eps_o*t4
% Place Tx at Ey, (i,j+1/2)

% ic=[i(1)-2:i(end)+2];
% jc=[j(1)-2:j(end)+2];

c=299792458;
mu_o=4*pi*10^-7;

eps_o=(1/(c*c*mu_o));



% t1=\px(ExEx)
Ex2=(0.5)*(Ex(i,j)+Ex(i,j+1)); % Solve  for Ex at i+1/2,j+1/2
Ex1=(0.5)*(Ex(i-1,j)+Ex(i-1,j+1));

t1=(1/dx)*(Ex2.^2-Ex1.^2);

% t2=\px(EyEy)
Ey2=Ey(i+1,j).^2;
Ey1=Ey(i-1,j).^2;

t2=(1/(2*dx))*(Ey2-Ey1);

% t3=\px(BzBz)
Hz2=Hz(i,j).^2;
Hz1=Hz(i-1,j).^2;
t3=(1/(dx))*(Hz2-Hz1);

% t4=\py(ExEy)

Dx2=(0.5)*(Dx(i,j)+Dx(i,j+1)); % Solve  for Ex at i+1/2,j+1/2
Dx1=(0.5)*(Dx(i-1,j)+Dx(i-1,j+1));

t4=(1/(dx))*(Dx2.*Ex2-Dx1.*Ex1);

% t5=
Dx2=1/4*(Dx(i,j+1)+Dx(i-1,j+1)+ Dx(i,j+2)+Dx(i-1,j+2));
Dx1=1/4*(Dx(i,j)+Dx(i-1,j)+ Dx(i,j-1)+Dx(i-1,j-1));

t5=(1/(2*dy))*(Dx2.*Ey(i,j+1)-Dx1.*Ey(i,j-1));


Tx(i,j)=(0.5)*eps_o.*(t1+t2)+0.5*(mu_o).*t3-t4-t5;
end