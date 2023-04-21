%**************** Electronical Components **********************
tata = transpose(RC);
% data = transpose(RLC);

RC1 = tata(1:2219,1);
RC2 = tata(1:2219,2);
RC3 = tata(1:2219,3);

% RLC1 = data(1:2219,1);
% RLC2 = data(1:2219,2);
% RLC3 = data(1:2219,3);

%**************** Electronical Components **********************
Vs = 4.7837;
C=220*10^-6;
L=0.0001;
R=19.7*10^+3;

%******************* Numerical Solution ************************
time_interval = [0 80];
initials = 0;
group6 = @(t, Vc)(Vs/(R*C)-Vc./(R*C));
[t, Vc] = ode45(group6,time_interval,initials); 

%******************* Analitical Solution ***********************
ti = [0:0.1:80];
analitical_solution = dsolve('DY =(Vs-Y)/(R*C)','Y(0)=0');
pretty(analitical_solution);
final_solution = simplify(analitical_solution);
solution_to_be_plotted = Vs - Vs*exp(-ti/(C*R));

%********************* Source Voltage **************************
x = 0:0.001:80;
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
plot(RC1(1:800,1),RC3(165:964,1),'m','LineWidth',1);
hold on
plot(x, const(x),'r','LineWidth',1);
hold on
plot(p, constant(p),'y','LineWidth',3);

legend('Analitical Solution','Numerical Solution','Experimental Data','Source Voltage');
xlabel("Time (s)");
ylabel("Voltage (V)");
title("RC Circuit");

