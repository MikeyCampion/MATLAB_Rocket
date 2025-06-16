% 
%          Main Script 
%
%          Version 1
%          Paul Flood  
%          23/05/2023
%

% constants 
lb = 1/2.205; % Conversion factor: pounds to kilograms
feet = 1/3.281; % Conversion factor: feet to meters
Sy_O = (38) * feet; % Vertical distance of main engine to G (m)
Orbiter_empty = 165000 * lb; % Mass of the empty orbiter (kg)
Payload = 65000 * lb;  % Mass of the payload (kg)
Orbiter_mass = Orbiter_empty + Payload; % Total mass of the orbiter (kg)                                        
i = 0.1; % Iteration step size

% This section initializes the initial values of constants required for the
% first iteration of the Runge-Kutta method.

u = 0;  %  m/s
v = 0;  %  m/s
h = 0;  %  m
g = 9.81 ; % m/s^2
T = 216.65; % kelvin
SA_Orbiter = 40; % Surface area of Orbiter
SA_Rocket = 55.42 + 10.18*2; % Surface area of Rocket
theta = 0; % Initialise angle
k = 0; % Intialise drag 
Rocket_Jettison = 125;  %time when SRBs are jettisoned
Tank_Jettison = 518;    %time fuel tank is jettisoned

% creates a storage matrix which will consist of time, mach, height, drag,
% engine angle
Space_Shuttle_Data_Matrix = zeros(5201,5);

% main loop
for n = 1:5201
    
    % Calculate the time for the given iteration
    t = (n-1)*i;
    Space_Shuttle_Data_Matrix(n,1) = t;
    
    %  Calculate forces based on time and temperature
    [F1,F2] = Space_Shuttle_Force_Finder(t,T);
    
    % Use fourth-order Runge-Kutta to find velocity 'v' and calculate
    % displacement
    v = runge_kutta_rocket(v,g,t,F1,F2,k);
    s = ((u+v)/2)*i;
    h = h +s;
    Space_Shuttle_Data_Matrix(n,3) = h;
    
    % Update velocity 'u'
    u = v;
    
    % Calculate coefficients for back iteration in Runge-Kutta 
    
    % Calculates constants relating to height and air density
    g = gravity(h);
    [density,a,T] = Density_Mach_Temp_finder(h,g);
    [Cd_R,Cd_O,mach] = drag_coefficient_finder(a,v);
    Space_Shuttle_Data_Matrix(n,2) = mach;
    
    % Calculate drag forces
    drag_R = 1/2*density*Cd_R*SA_Rocket*(v^2);
    drag_O = 1/2*density*Cd_O*SA_Orbiter*(v^2);

    Q = drag_O;
    Space_Shuttle_Data_Matrix(n,4) = Q;

    k = (1/2)*density*(Cd_R*SA_Rocket + Cd_O*SA_Orbiter);
    
    % Calculates coefficients for thrust and time
    [mass,mass_tank] = mass_finder(t);
    Sx_O = (28*mass_tank)/(Orbiter_mass+mass_tank)*feet;
    Sx_R = (28*feet)-Sx_O;

    % Determine thrust angle
    if  t < (Tank_Jettison -1)
    theta  = Thrust_Angle_finder((F1-drag_R),F2,drag_O,Sx_R,Sx_O,Sy_O,theta);
    F2 = theta*F2;
    else 
         theta = 0;
    end
    
    Space_Shuttle_Data_Matrix(n,5) = theta;
    
    % Adjust Space Shuttle surface area based on jettonisation
    if t > Rocket_Jettison 
        SA_Rocket = 55.42 ;
        

   elseif t > Tank_Jettison
        SA_Rocket = 0 ;
    end
% Plots of engine angle, height, speed, drag with respect to time, 
% just remove a % to run it  

% plot(Space_Shuttle_Data_Matrix(:,1), Space_Shuttle_Data_Matrix(:,4))
% plot(Space_Shuttle_Data_Matrix(:,1), Space_Shuttle_Data_Matrix(:,3))
% plot(Space_Shuttle_Data_Matrix(:,1), Space_Shuttle_Data_Matrix(:,2))
% plot(Space_Shuttle_Data_Matrix(:,1), Space_Shuttle_Data_Matrix(:,5))
end