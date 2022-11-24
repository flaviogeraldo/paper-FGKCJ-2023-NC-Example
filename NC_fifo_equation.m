%% Flávio Geraldo Coelho Rocha
%% Nov 23/2022
%% Input
R=[0.05E+9 0.1E+9 0.25E+9 0.25E+9 0.25E+9]; %switch transmission rate
T=[40.96E-6 40.96E-6 20E-6+16.384E-6 20E-6+8.192E-6 20E-6+4.096E-6]; %fixed delay
rho=[1024E+03 512E+03 256E+03]; %flow cte rate
sigma=[1024 4096 2048]; %flow burst
foi=1; %foi=flow of interest
phi=[0.5 0.25 0.25 0.125 0.0625]; %switch share for each queue
%% Preparation
Rs=R.*phi; %queue share
rho_y=sum([rho(1:foi-1) rho(foi+1:end)]);
sigma_y=sum([sigma(1:foi-1) sigma(foi+1:end)]);
S=length(R);
%% Initialization
sigma_vector=zeros(1,S);
%% For S switches
for i=1:S
    if i==1
        sigma_vector(i)=sigma_y/Rs(i); 
    else
    sigma_vector(i)=(sigma_y+rho_y*sum(T(1:i-1)))/Rs(i); %eq. 68
    end
end
razao1=sigma(foi)/min(Rs-rho_y);%eq. 67 part I
razao2=sum(T)+sum(sigma_vector);%eq. 67 part II
%% Output
delay=razao1+razao2;
