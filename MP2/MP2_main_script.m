% Script to create animation of shuttle flight.
% Output is mp4 file of animation.

% Version 1: Created 25/05/2023. Author: Michael Campion

Rocket_Jettison = 125;  %time when SRBs are jettisoned
Tank_Jettison = 518;    %time fuel tank is jettisoned

 VideoObject = VideoWriter('DrawFlight.mp4','MPEG-4');
 VideoObject.FrameRate = 5;
 VideoObject.Quality = 100; 
 VideoObject.FileFormat
 open(VideoObject); 
 i=1; 
 height = Space_Shuttle_Data_Matrix(:,3)*3.281;
 engine_angle = Space_Shuttle_Data_Matrix(:,5)*180/pi;
 step_size = 25;

 % Before launch
 for count = 1:10
     handlefig = figure();
 
     patch([-60 60 60 -60 -60],[-60 -60 60 60 -60],[-10 -10 -10 -10 -10],'green')
     hold on
     Draw_Shuttle(-3,4.25,0,0,engine_angle(i))
     hold on
     Draw_Tank(0,0,2)
     hold on
     Draw_SRB(-4.25-1.85,0,0,0)
     hold on
     Draw_SRB(4.25+1.85,0,0,0)
     hold off
     set(gca,'Color','b')
 
    current_frame = getframe(handlefig);
    writeVideo(VideoObject,current_frame);
    close(handlefig)

 end

 % Flight with ground still in frame
 while Space_Shuttle_Data_Matrix(i,3)<500
 i= i+5;

 handlefig = figure();
 patch([-60 60 60 -60 -60],[-60 -60 60 60 -60],[-10 -10 -10 -10 -10],'green')
 hold on
 Draw_Shuttle(-3,4.25,0+height(i),1,engine_angle(i))
 hold on
 Draw_Tank(0,0,2+height(i))
 hold on
 Draw_SRB(-4.25-1.85,0,0+height(i),1)
 hold on
 Draw_SRB(4.25+1.85,0,0+height(i),1)
 hold off
 set(gca,'Color','b')
 
 current_frame = getframe(handlefig);
 writeVideo(VideoObject,current_frame);
 close(handlefig)
 end  

 % Flight with ground out of frame
 while Space_Shuttle_Data_Matrix(i,1)<Rocket_Jettison
 i= i+step_size;

 handlefig = figure();
 patch([-60 60 60 -60 -60],[-60 -60 60 60 -60],[-10+height(i) -10+height(i) -10+height(i) -10+height(i) -10+height(i)],'blue')
 hold on
 Draw_Shuttle(-3,4.25,0+height(i),1,engine_angle(i))
 hold on
 Draw_Tank(0,0,2+height(i))
 hold on
 Draw_SRB(-4.25-1.85,0,0+height(i),1)
 hold on
 Draw_SRB(4.25+1.85,0,0+height(i),1)
 hold off
 set(gca,'Color','b')
 
 current_frame = getframe(handlefig);
 writeVideo(VideoObject,current_frame);
 close(handlefig)
 end  

 % Loop to jettison SRBs 
 for count = 1:20
     handlefig = figure();
   
     hold on
     Draw_Shuttle(-3,4.25,0+height(i)+25*count,1,engine_angle(i))
     hold on
     Draw_Tank(0,0,2+height(i)+25*count)
     hold on
     Draw_SRB(-4.25-1.85,0,0+height(i)-count,0)
     hold on
     Draw_SRB(4.25+1.85,0,0+height(i)-count,0)
     hold off
     set(gca,'Color','b')
 
    current_frame = getframe(handlefig);
    writeVideo(VideoObject,current_frame);
    close(handlefig)

 end 

% Flight between SRB jettison and tank jettison
 while Space_Shuttle_Data_Matrix(i,1)<Tank_Jettison
     handlefig = figure();
     
     i = i+step_size;
     if i>5201 
        i = i-step_size+1;
         break
     
     else
     patch([-60 60 60 -60 -60],[-60 -60 60 60 -60],[-10+height(i) -10+height(i) -10+height(i) -10+height(i) -10+height(i)],'blue')
     hold on
     Draw_Shuttle(-3,4.25,0+height(i),1,engine_angle(i))
     hold on
     Draw_Tank(0,0,2+height(i))
     hold off
     set(gca,'Color','b')
 

    current_frame = getframe(handlefig);
    writeVideo(VideoObject,current_frame);
    close(handlefig)
     end
 end

% Jettison external tank
  for count = 1:20
     handlefig = figure();
    
     hold on
     Draw_Shuttle(-3,4.25,0+height(i)+25*count,0,engine_angle(i))
     hold on
     Draw_Tank(0,0,2+height(i)-count)
     hold off
     set(gca,'Color','b')
 
    current_frame = getframe(handlefig);
    writeVideo(VideoObject,current_frame);
    close(handlefig)

  end 

  for count = 1:5
     handlefig = figure();
     
     axis([-60 60 -60 60 -10+height(i)+count*50 60+height(i)+count*50])
     patch([-60 60 60 -60 -60],[-60 -60 60 60 -60],[-10+height(i)+count*50 -10+height(i)+count*50 -10+height(i)+count*50 -10+height(i)+count*50 -10+height(i)+count*50],'blue')
     hold on
     hold on
     Draw_Shuttle(-3,4.25,0+height(i)+count*50,0,engine_angle(i))
     hold off
     set(gca,'Color','b')
 
    current_frame = getframe(handlefig);
    writeVideo(VideoObject,current_frame);
    close(handlefig)

  end 

 close(VideoObject)
