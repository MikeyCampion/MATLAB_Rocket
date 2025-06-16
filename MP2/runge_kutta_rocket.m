function [v] = runge_kutta_rocket(v,g,t,F_1,F_2,k)
%
% Function to utilise the Runge-Kutta method to solve a simplified 
% first-order ordinary differential equation of the form f(v, t) and find
% the velocity of a rocket at a given time.
%
% Inputs: 
%   t:  time (s) (real, scalar)
%   v: velocity (m/s)  (real, scalar) 
%   g:  gravitational constant (real, scalar, positive)
%   F_1:  solid rocket thrust force  (m/s) (real, scalar)
%   F_2: vertical component of engine thrust force  (m/s) (real, scalar) 
%   k:  coefficient of drag (real, scalar)
%
% Outputs:
%   v:  velocity (m/s) (real, scalar)

%
%          Version 1
%          Paul Flood  
%          23/05/2023
%

% Error Checks
if (~isscalar(t)) || (~isreal(t)) || t<0
error('The input (t) must be real, positive, and scalar number.')
end

if (~isscalar(g)) || (~isreal(g)) || g <= 0
error('The input (g) must be real, positive, and scalar number.')
end

if (~isscalar(v)) || (~isreal(v)) 
error('The input (v) must be real, positive, and scalar number.')
end

iterations = .1; %iteration step size 

% Runge-kutta weightings
W_1 = 1/6;
W_2 = 1/3;
W_3 = 1/3;
W_4 = 1/6;

alpha_1 = 1/2;
alpha_2 = 1/2;
alpha_3 = 1;

beta_1 = 1/2;
beta_2 = 1/2; 
beta_3 = 1;

% Anonymous function to be solved
f = @(t,v,k,g,F_1,F_2) ((F_1+F_2)-(k*(v^2))-((mass_finder(t)*g)))/mass_finder(t);

% Runge-Kutta constants 
k_1 = iterations*f(t,v,k,g,F_1,F_2);
k_2 = iterations*f((t+alpha_1*iterations),(v+beta_1*iterations),k,g,F_1,F_2);
k_3 = iterations*f((t+alpha_2*iterations),(v+beta_2*iterations),k,g,F_1,F_2);
k_4 = iterations*f((t+alpha_3*iterations),(v+beta_3*iterations),k,g,F_1,F_2);

% Updated velocity 
v = v+(W_1*k_1 + W_2*k_2 + W_3*k_3 + W_4*k_4);

end