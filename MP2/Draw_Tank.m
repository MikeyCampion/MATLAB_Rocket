function [] = Draw_Tank(x_shift,y_shift,z_shift)
% Function to draw the external tank.
% Inputs: 
% x_shift(value to shift the position of the tank in the x-axis in m)
% y_shift(value to shift the position of the tank in the y-axis in m)
% z_shift(value to shift the position of the tank in the z-axis in m)

% Version 1: created: 23/05/2023. Author: Michael Campion

if (~(isreal(x_shift)))
    error('x_shif must be real')
end
if (~(isreal(y_shift)))
    error('y_shift must be real')
end
if (~(isreal(z_shift)))
    error('z_shift must be real')
end

[X1,Y1,Z1] = cylinder(4.25);
surf_handle1 = surf(X1 + x_shift,Y1 + y_shift,36*Z1 +z_shift) ;
set(surf_handle1,'LineStyle','none','FaceColor',[0.8500 0.3250 0.0980])
axis equal
hold on 
light

[X2,Y2,Z2] = ellipsoid(0,0,0,4.25,4.25,11);
X2 = X2(11:end,:);       
Y2 = Y2(11:end,:);    
Z2 = Z2(11:end,:);  
surf_handle2 = surf(X2 + x_shift,Y2 + y_shift,Z2 + 36 + z_shift);
set(surf_handle2,'LineStyle','none','FaceColor',[0.8500 0.3250 0.0980]) 

[X3,Y3,Z3] = ellipsoid(0,0,0,4.25,4.25,2);
X3 = X3(11:end,:);       
Y3 = Y3(11:end,:);    
Z3 = Z3(11:end,:); 
surf_handle3 = surf(X3 + x_shift,Y3 + y_shift,-Z3 + z_shift);
set(surf_handle3,'LineStyle','none','FaceColor',[0.8500 0.3250 0.0980])

hold off
end