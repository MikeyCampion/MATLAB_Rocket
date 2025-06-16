function [mass,mass_tank] = mass_finder(t)
% 
% Function calculate the total mass of the rocket and the mass of
% the rocket excluding the orbiter, based on the given time (in seconds).
%
% Inputs:
%   t: time (seconds)
%
% Outputs:
%   mass: Total mass of the rocket (kg)
%   mass_tank: Mass of the rocket excluding the orbiter (kg)

%
%          Version 1
%          Paul Flood  
%          23/05/2023
%

pounds = 0.453592; % Conversion Factor: pounds to kg
density_O2 = 4.137455; % Density of O2 in kg/gallon
density_H2 = .27716785; % Density of H2 in kg/gallon 
ratio_O2 = .2698; % Percentage of propelant that is O2 
ratio_H2 = .7302; % Percentage of propelant that is H2 
SRB_mass_flow_rate = 7.3710E3; % Mass flow rate of SRBs (Kg/s)

% Calculation for solid rocket boosters
SRB = 1107000;
if t <= 124
    SRB = (SRB - (t*SRB_mass_flow_rate))*pounds;

else 
    SRB = 193000*pounds;
end

% Calculation for Orbiter
orbiter = 217513*pounds;


% Calculation for main tank
empty_tank = 781000*pounds; % Empty tank mass (kg)
VH2 = 395582;
VO2 = 146181;

T_0 = 0;
T_1 = 30; 
T_2 = 62;
T_3 = 125;
T_4 = 511;
T_5 = 518;

V_dot = 1050; % Volumetric flow rate (gallons/second)

if (t >= T_0) && (t <= T_1)
    thrust = .9;
    VH2 = VH2-(t*(V_dot*thrust*ratio_H2));
    VO2 = VO2-(t*(V_dot*thrust*ratio_O2));  
end
    
if t>T_1
     thrust = .9;
     VH2 = VH2-(30*(V_dot*thrust*ratio_H2));
     VO2 = VO2-(30*(V_dot*thrust*ratio_O2));   
end

if (t > T_1) && (t <= T_2)  
      thrust = .65;
      VH2 = VH2-((t-30)*(V_dot*thrust*ratio_H2));
      VO2 = VO2-((t-30)*(V_dot*thrust*ratio_O2));
end

if t > T_2
      thrust = .65;
      VH2 = VH2-((62-30)*(V_dot*thrust*ratio_H2));
      VO2 = VO2-((62-30)*(V_dot*thrust*ratio_O2));        
end
 

if (t > T_2) && (t <= T_4)  
      thrust = 1.04;
      VH2 = VH2-((t-62)*(V_dot*thrust*ratio_H2));
      VO2 = VO2-((t-62)*(V_dot*thrust*ratio_O2));     
end

if t > T_4
      thrust = 1.04;
      VH2 = VH2-((511-62)*(V_dot*thrust*ratio_H2));
      VO2 = VO2-((511-62)*(V_dot*thrust*ratio_O2));       
end

MO2 = VO2*density_O2;
MH2 = VH2*density_H2;

if (t<T_3) 
    mass = MO2+MH2+(SRB*2)+empty_tank+orbiter;  
end

if (t >= T_3) && (t < T_5)
    mass = MO2+MH2+empty_tank+orbiter;
end

if (t >= T_5)
    mass = orbiter;    
end

mass_tank = mass - orbiter;
end
