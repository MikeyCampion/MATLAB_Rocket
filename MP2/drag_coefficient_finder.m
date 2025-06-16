function [Cd_R,Cd_O,Mach] = drag_coefficient_finder(a,v)
% 
% Function to calculate the drag coefficients for a rocket and tank
% (Cd_R) and an orbiter (Cd_O) based on the given speed of sound in air
% (a) and velocity (v). It also determines the velocity relative to the
% speed of sound (mach).
%
% Inputs:
%   a: Speed of sound in air in m/s (real, scalar, positive).
%   v: Velocity in m/s (real, scalar).
%
% Outputs:
%   Cd_R: Drag coefficient of the rocket and tank (real, scalar, positive)
%   Cd_O: Drag coefficient of the orbiter (real, scalar, positive).
%   mach: Velocity relative to the speed of sound (real, scalar, positive)

%
%          Version 1
%          Paul Flood  
%          23/05/2023
%

% Error Checks
if (~isscalar(a)) || (~isreal(a)) || a <= 0
    error('Input (a) must be a real, positive and scalar number.')
end

if (~isscalar(v)) || (~isreal(v)) || v < 0
    error('Input (v) must be a real and scalar number.')
end

% Calculate Mach velocity
Mach = v/a;

% These represent specific Mach velocities at which the drag coefficient
% values are known.
Mach_Part_1 = .8;
Mach_Part_2 = 1;
Mach_Part_3 = 2;

% Slope of the linear interpolation for the Solid Rocket Boosters and Tank 
% drag coefficient between:
slope_1_R = 1.05/.2; % Part 1 and Part 2
slope_2_R = -.7; % Part 2 and Part 3

% Slope of the linear interpolation for the Orbiter drag coefficient 
% between:
slope_1_O = (1.75/.2);% Part 1 and Part 2
slope_2_O = -1.1; % Part 2 and Part 3

% Initial drag coefficients
Cd_O = .75; % Orbiter
Cd_R = .25; % Rocket

if (Mach >= Mach_Part_1) && (Mach < Mach_Part_2)
    Cd_O = .75  + (Mach-Mach_Part_1)*(slope_1_O);
    Cd_R = .25  + (Mach-Mach_Part_1)*(slope_1_R);
end

if (Mach >= Mach_Part_2) && (Mach < Mach_Part_3)
    Cd_O = 2.5  + (Mach-Mach_Part_2)*(slope_2_O);
    Cd_R = 1.3  + (Mach-Mach_Part_2)*(slope_2_R);   
end

if Mach >= Mach_Part_3
    Cd_O = 1.4;
    Cd_R = .4;
end 

end