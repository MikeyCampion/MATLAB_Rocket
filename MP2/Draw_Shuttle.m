function [] = Draw_Shuttle(x_shift,y_shift,z_shift,thrust,angle)
% Function to draw the shuttle at a given position with thrust from
% main engines. The angle of the engines can also br changed 
% Inputs: 
% x_shift(value to shift the position of the shuttle in the x-axis in m)
% y_shift(value to shift the position of the shuttle in the y-axis in m)
% z_shift(value to shift the position of the shuttle in the z-axis in m)
% thrust(turn the thrust either on or off takes value 1 or 0)
% angle(angle of the engines in degrees) 

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
if (~(isreal(thrust)))
    error('thrust must be real')
end
if (~(isreal(angle)))
    error('angle must be real')
end
% Main body
x = linspace(0,6,20);
y = sqrt(9 - ((x-3).^2))+4;
X = [x 6 0 0;x 6 0 0];
Y = [abs(y) 0 0 4;abs(y) 0 0 4];
Z = [zeros(1,23); 30*ones(1,23)]; 
surf_handle1 = surf(X + x_shift,Y + y_shift,Z + z_shift);
set(surf_handle1,'linestyle','none','FaceColor',[0.9 0.9 0.9])
patch([x 6 0 0] + x_shift,[abs(y) 0 0 4] + y_shift,[zeros(1,23)] + z_shift,'white') 
hold on 
view([-227.9 33.0]) 


x1 = [linspace(1.5,4.5,20) linspace(4.5,1.5,20)];
xa = linspace(1.5,4.5,20);
xb = linspace(4.5,1.5,20);
y1 = [(sqrt(1.5^2 - (xa-3).^2)+2) -(sqrt(1.5^2 - (xb-3).^2)-2) ];
X1 = [x 6*ones(1,7) linspace(6,0,6) zeros(1,7);x1];
Y1 = [abs(y) linspace(4,0,6) zeros(1,8) linspace(0,4,6);y1];
Z1 = [30*ones(1,40);36*ones(1,40)];
surf_handle2 = surf(X1 + x_shift,Y1 + y_shift,Z1 + z_shift);
set(surf_handle2,'linestyle','none','FaceColor',[0.9 0.9 0.9])



[X2,Y2,Z2] = sphere;      
X2 = X2(11:end,:);       
Y2 = Y2(11:end,:);    
Z2 = Z2(11:end,:);      
r = 1.5;              
surf_handle3 = surf(r.*X2+3 + x_shift,r.*Y2+2 + y_shift,r.*Z2+36 + z_shift); 
set(surf_handle3,'linestyle','none','FaceColor',[0.1 0.1 0.1])
light

% Wings 
X3 = [6 8 14.5 14.5 8 6 6;6 8 14.5 14.5 8 6 6];
Y3 = [0 0 0 1 1 1 0;0 0 0 1 1 1 0];
Z3 = [0 0 0 0 0 0 0;30 15 3.5 3.5 15 30 30];
surf_handle4 = surf(X3 + x_shift,Y3 + y_shift,Z3 + z_shift);
set(surf_handle4,'linestyle','none','FaceColor',[0.9 0.9 0.9])

X4 = -(X3-6);
Y4 = [0 0 0 1 1 1 0;0 0 0 1 1 1 0];
Z4 = [0 0 0 0 0 0 0;30 15 3.5 3.5 15 30 30];
surf_handle5 = surf(X4 + x_shift,Y4 + y_shift,Z4 + z_shift);
set(surf_handle5,'linestyle','none','FaceColor',[0.9 0.9 0.9]) 

X5 = [6 8 14.5 14.5 8 6 6];
Y5 = [0 0 0 1 1 1 0];
Z5 = [30 15 3.5 3.5 15 30 30];
patch(X5 + x_shift,Y5 + y_shift,[0 0 0 0 0 0 0]+ z_shift,'black')
patch(X5 + x_shift,Y5 + y_shift,Z5 + z_shift,'black')

X6 = [0 -2 -8.5 -8.5 -2 0 0];
Y6 = Y5;
Z6 = Z5;
patch(X6 + x_shift,Y6 + y_shift,Z6 + z_shift,'black') 
patch(X6 + x_shift,Y6 + y_shift,[0 0 0 0 0 0 0] + z_shift,'black') 

% Tail 
X7 = [2.5 2.5 3.5 3.5 2.5;2.5 2.5 3.5 3.5 2.5];
Y7 = [7 14.5 14.5 7 7;7 14.5 14.5 7 7];
Z7 = [0 -2 -2 0 0;10 2 2 10 10];
surf_handle7 = surf(X7 + x_shift,Y7 + y_shift,Z7 + z_shift);
set(surf_handle7,'linestyle','none','FaceColor',[0.9 0.9 0.9]) 
patch([2.5 2.5 3.5 3.5 2.5]+ x_shift,[7 14.5 14.5 7 7]+ y_shift,[0 -2 -2 0 0]+ z_shift,'black')
patch([2.5 2.5 3.5 3.5 2.5]+ x_shift,[7 14.5 14.5 7 7] + y_shift,[10 2 2 10 10]+ z_shift,'black') 

%Engines
[X8,Y8,Z8] = cylinder([1.25,0.75]);
surf_handle8 = surf(X8+1.5 +x_shift,Y8+2 +y_shift,3*Z8-3 + z_shift,'FaceColor','black');
surf_handle9 = surf(X8+4.5+x_shift,Y8+2 + y_shift,3*Z8-3 + z_shift,'FaceColor','black');
surf_handle10 = surf(X8+3 + x_shift,Y8+4.5 + y_shift,3*Z8-3 +z_shift,'FaceColor','black'); 

origin1 = [0 4.5 0+z_shift];
direction1 = [1 0 0];
rotate(surf_handle10,direction1,angle,origin1)

origin2 = [0 2 0+z_shift];
rotate(surf_handle9,direction1,angle,origin2)
rotate(surf_handle8,direction1,angle,origin2)

%Thrust 
if thrust == 1 
    [X9,Y9,Z9] = cylinder(1.25);
    surf_handle11 = surf(X9+1.5 +x_shift,Y9+2 +y_shift,6*Z9-9 + z_shift,'FaceColor','[1.0000    0.5216    0.0784]','LineStyle','none');
    surf_handle12 = surf(X9+4.5+x_shift,Y9+2 + y_shift,6*Z9-9 + z_shift,'FaceColor','[1.0000    0.5216    0.0784]','LineStyle','none');
    surf_handle13 = surf(X9+3 + x_shift,Y9+4.5 + y_shift,6*Z9-9 +z_shift,'FaceColor','[1.0000    0.5216    0.0784]','LineStyle','none');
    rotate(surf_handle13,direction1,angle,origin1)
    rotate(surf_handle12,direction1,angle,origin2)
    rotate(surf_handle11,direction1,angle,origin2)

hold off
end