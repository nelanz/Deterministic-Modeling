% Diffusion equation for irregular shape
close all
dt = 0.001;
dy=0.1;
dx = 0.1;
x = 0:dx:2;
t = 0:dt:2;
y=0:dy:2;
D = 5;
u = zeros(length(t), length(x),length(y));
Mapa = ones(length(y), length(x));
Mapa(1:floor(length(y)/2), floor((length(x)+1)/2):end) = 0; 
Mapa(1, 1:floor(length(y)/2)) = 2; % I
Mapa(1:floor(length(y)/2), floor((length(x)+1)/2)) = 3; 
Mapa(floor((length(y) +1)/2), floor((length(x)+1)/2): end) = 3; 
Mapa(floor((length(y) +1)/2):end, end) = 3; 
Mapa(:, 1) = 3; 
Mapa(end, :) = 4; 
u(1,:,:)=(sin(pi*x))'*sin(pi*y);

for t1 = 1:length(t)
   u(t1, 1, 1:floor(length(y)/2)) = dx*sin(dt*t1) + u(t1, 2, 1:floor(length(y)/2)); 
   u(t1, 1:floor(length(y)/2), floor((length(x)+1)/2)) = u(t1, 1:floor(length(y)/2), floor((length(x)+1)/2) - 1); 
   u(t1, floor((length(y) +1)/2), floor((length(x)+1)/2): end) = u(t1, floor((length(y) +1)/2) + 1, floor((length(x)+1)/2): end); 
   u(t1, floor((length(y) +1)/2):end, end) = u(t1, floor((length(y) +1)/2):end, end-1); 
   u(t1, :, 1) = u(t1, :, 2); 
   u(t1, end, :) = zeros(1, length(x)); 
   
   u(t1, 1, 1) = u(t1, 2, 2); 
   u(t1, 1, floor((length(x)+1)/2)) = u(t1, 2, floor((length(x)+1)/2)-1); 
   u(t1, floor((length(y)+1)/2), floor((length(x)+1)/2)) = u(t1, floor((length(y)+1)/2) + 1, floor((length(x)+1)/2)-1); 
   u(t1, floor((length(y)+1)/2), end) = u(t1, floor((length(y)+1)/2) +1 , end-1); 
   u(t1, end, end) = u(t1, end-1, end-1); 
   u(t1, end, 1) = u(t1, end-1, 2); 
   
    for x1 = 1:(length(x)-1) 
        for y1 = 1: (length(y)-1)
            if Mapa(y1, x1) == 1
              u(t1+1,x1,y1) = D*dt*(u(t1,x1+1,y1) + u(t1,x1-1,y1) + u(t1,x1,y1+1) +u(t1,x1,y1-1)- 4*u(t1,x1,y1))/(dx*dx) + u(t1,x1,y1);   
            end  
         end
    end
end

surf( squeeze(u(50,:,:)));
    zlim([-1, 1]);
    drawnow;