function [Angle] = Thrust_Angle_finder(F_R,T_O,drag,Sx_R,Sx_O,Sy_O,theta)
% 
% Function to calculate the thrust angle necessary to keep the rocket
% trajectory vertical for the orbiter of a simplified rocket model.
% 
% Inputs:
%   F_R:  Combined force in N acting on rocket  (N)   (Real scalar,positve)
%   T_O:  Thrust of Orbiter                     (N)   (Real scalar,positve)
%   Sx_R: Perpendicular distance of rocket
%         to Centre of Mass                     (m)   (Real scalar,positve)
%   Sx_O: Perpendicular distance of Orbiter 
%         to Centre of Mass                     (m)   (Real scalar,positve)
%   Sy_O: Vertical distance of Orbiter to 
%         Centre of Mass                        (m)   (Real scalar,positve)
%   drag: Drag acting on orbiter                      (Real scalar,positve)
%
% Outputs:
%   Angle: Estimated by the Newton-Raphson method (rads)

%
%               Version 1
%               Paul Flood  
%               23/05/2023
%

if (~isscalar(F_R)) || (~isreal(F_R)) 
error('The input (F_R) must be real and scalar number.')
end
if (~isscalar(T_O)) || (~isreal(T_O))
error('The input (T_O) must be real and scalar number.')
end
if (~isscalar(Sx_R)) || (~isreal(Sx_R)) || Sx_R <= 0
error('The input (Sx_R) must be real, positive, and scalar number.')
end
if (~isscalar(Sx_O)) || (~isreal(Sx_O)) || Sx_O <= 0
error('The input (Sx_O) must bereal, positive, and scalar number.')
end
if (~isscalar(Sy_O)) || (~isreal(Sy_O)) || Sy_O <= 0
error('The input (Sy_O) must be real, positive, and scalar number.')
end

saftey = theta;

% The following anonymous functions will be solved utilizing the 
% Newton-Raphson method.
Net_Moment = @(a) (F_R*Sx_R) + (T_O*sin(a)*Sy_O)... 
-(T_O*cos(a)*Sx_O) - drag;
Net_dMoment = @(a) (T_O*(cos(a))*Sy_O) + T_O*(sin(a))*Sx_O;

% Iteration limit and initial guess used in the Newton-Raphson method
Iterations = 20; 
Angle =theta;

for count = 1:Iterations+1
    
    % This if statement triggers an error message if the iteration limit 
    % has been reached, indicating that further convergence is unlikely.

    if count == Iterations 
        theta = saftey;
        break
    end
       % Newton-Raphson iteration is used to update the value of the 
       % variable `Angle` based on the net moment and its derivative. This
       % code calculates the net moment using the function Net_Moment and
       % its derivative using Net_dMoment. 
       
       f= Net_Moment(Angle);
       df= Net_dMoment(Angle);
       Angle = Angle - f/df;
        
       % This statement prevents the code from breaking if the slope of 
       % f(Angle) is 0
        
       if Net_dMoment(Angle)== 0
           Angle = Angle + .001;
       end

       % This line causes the loop to end once the tolerance is reached
       if f*f < .00000001
           break
       end
       
end

end