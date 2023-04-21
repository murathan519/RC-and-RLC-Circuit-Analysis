%**************** Electronical Components **********************
% tata = transpose(RC);
data = transpose(RLC);

% RC1 = tata(1:2219,1);
% RC2 = tata(1:2219,2);
% RC3 = tata(1:2219,3);

RLC1 = data(1:2219,1);
RLC2 = data(1:2219,2);
RLC3 = data(1:2219,3);

%**************** Electronical Components **********************
Vs = 4.7837;
C=220*10^-6;
L=0.0001;
R=19.7*10^+3;

%******************* Numerical Solution ************************
time_interval = [0 60];
initials = [0 0];
group6 = @(t, Vc) [Vc(2);(-(R/L)*Vc(2)+(Vs-Vc(1))/(L*C))];
[t, Vc] = ode23s(group6,time_interval,initials); 

%******************* Analitical Solution ***********************
ti = [0:0.1:60];
analitical_solution = dsolve('D2Y = -(R/L)*DY + (Vs-Y)/(L*C)','Y(0)=0','DY(0)=0');
pretty(analitical_solution);
final_solution = simplify(analitical_solution);
solution_to_be_plotted = Vs-(Vs*exp(-(ti*((C^2*R^2 - 4*L*C)^(1/2) + C*R))/(2*C*L))*((C^2*R^2 - 4*L*C)^(1/2) - C*R))/(2*(C^2*R^2 - 4*C*L)^(1/2)) - (Vs*exp((ti*((C^2*R^2 - 4*L*C)^(1/2) - C*R))/(2*C*L))*((C^2*R^2 - 4*L*C)^(1/2) + C*R))/(2*(C^2*R^2 - 4*C*L)^(1/2));

%********************* Source Voltage **************************
x = 0:0.001:60;
c = Vs;
const = @(x)(c).*x.^(0);

p = 0:0.001:80;
d = Vs*0.97;
constant = @(p)(d).*p.^(0);

%************************* Plots *******************************
plot(ti,solution_to_be_plotted,'bo','LineWidth',1);
hold on;
plot(t,Vc(:,1),'g-','LineWidth',2);
hold on;
plot(RLC1(1:591,1),RLC3(97:687,1),'m','LineWidth',1);
hold on
plot(x, const(x),'r','LineWidth',1);
hold on
plot(p, constant(p),'y','LineWidth',3);

legend('Analitical Solution','Numerical Solution','Experimental Data','Source Voltage');
xlabel("Time (s)");
ylabel("Voltage (V)");
title("RLC Circuit");