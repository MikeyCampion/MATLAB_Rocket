function [F1,F2] = Space_Shuttle_Force_Finder(t,T)
% 
% Function to calculate the thrust forces for the solid rocket boosters
% (F1) and the main engine (F2) based on the given time into launch (t)
% and the absolute temperature of the surroundings (T).
%
% Inputs:
%   T:  Absolute temperature of surroundindgs (K)(real, scalar, positve) 
%   t:  Time into launch (s) (real, scalar, positve)
%
% Outputs: 
%   F1: Thrust force of the solid rocket boosters (real, scalar) 
%   F2: Thrust force of the main engine (real, scalar)

%
%          Version 1
%          Paul Flood  
%          23/05/2023
%

% Error Checks
if (~isscalar(t)) || (~isreal(t)) || t < 0
error('Input (t) must be a real, positive and scalar number.')
end

if (~isscalar(T)) || (~isreal(T)) || T <= 0
error('Input (T) must be a real, positive and scalar number.')
end

% Define constants 
pounds = 4.448; % Conversion factor: lb to newtons 
T_f = 216.15; % Kelvin
force_lapse_rate = 87/71.5;
Engine_Quantity = 3;
vaccum_thrust = 470000;

T_1 = 30; % Time that main engines throttles down to 65%
T_2 = 62; % Time that main engines throttles up to 104%
T_3 = 511; % Time that main engines cut-off (MECO)

% Calculate the combined thrust for the main engines
orbiter_thrust = Engine_Quantity*(vaccum_thrust - force_lapse_rate*...
    (T-T_f))*pounds ;

% Determine the throttle value based on given time
if t < T_1 
        throttle_value = .9;

elseif (t >= T_1) && (t < T_2)
        throttle_value = .65;

elseif (t >= T_2) && (t < T_3)
        throttle_value = 1.04;

elseif  t >= T_3 
        throttle_value = 0;
end

% Calculate thrust force of orbiter engine
F2 = orbiter_thrust*throttle_value;

% Calculate thrust force of solid rocket boosters
if t <= 124 
    F1 = 2*2650000*pounds;
else 
    F1 = 0;
end


end