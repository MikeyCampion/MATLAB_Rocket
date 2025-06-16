function [g] = gravity(h)
%   This function calculates the acceleration due to gravity of a 
%   body at distance h above earths surface using newtons law of 
%   of gravitation.
%   
%   Inputs 
%   h = (real, scalar, positive) height above earths surface in meters 
%
%   Outputs
%   g = acceleration due to gravity calculated by newtons law of 
%   gravitation 
%
%   Constants 

R0 = 12742000/2; % radius of earths surface (m)
M = 5.97E24;     % mass of earth (kg)
G = 6.67E-11;    % gravitational constant s

g = (G*M)/((R0+h)^2);

end