function [density,a,T] = Density_Mach_Temp_finder(h,g)
%
% Function to calculate the air density (density), speed of sound (a),
% and temperature (T) at a given altitude (h) using the acceleration due
% to gravity (g).
%
% Inputs:
%   h: Altitude (m) (real, scalar).
%   g: Acceleration due to gravity(m/s^2) (real, scalar).
%
% Outputs:
%   density: Air density (kg/m^3)
%   a: Speed of sound (m/s)
%   T: Temperature (K)

%
%          Version 1
%          Paul Flood  
%          23/05/2023
%

% Error checks
if (~isscalar(h)) || (~isreal(h))
    error('Input (h) must be a real scalar number.')
end

if (~isscalar(g)) || (~isreal(g))
    error('Input (g) must be a real scalar number.')
end

% Constants
p_0 = 1.225;        % Sea level air density (kg/m^3)
L = 6.5;           % Temperature lapse rate (K/km)
T_0 = 288.15;       % Sea level temperature (K)
R = 8.31447;       % Universal gas constant (J/(mol·K))
M = 0.0289644;     % Molar mass of Earth's air (kg/mol)
R_2 = 287;          % Specific gas constant for dry air (J/(kg·K))
gamma = 1.4;       % Specific heat ratio for air

% Calculate temperature at altitude
if h <= 11000
    T = T_0-(6.5*h/1000); % Linear temperature decrease up to 11 km
else 
    T = 216.65;          % Temperature remains constant above 11 km
end

% Calculate the speed of sound
a = (gamma*R_2*T)^(1/2);

% Calculate air density
density = p_0*(1-(L*h/1000)/T_0)^(((g*M)/(R*L/1000))-1);

% Set density to a constant value above 35 km
if h>= 35000
    density = .0016;
end

end