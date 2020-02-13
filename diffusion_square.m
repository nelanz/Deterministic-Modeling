%Diffusion equation for square

clear all
dt = 0.001;
dx = 0.1;
dy = 0.1
T = 1;
x = 0:dx:1;
t = 0:dt:T;
y = 0:dy:1;
D = 0.5;
u = zeros(length(t), length(x), length(y)); %11x11
u(1,:,:) = sin(pi * x)' * sin(pi * y); 

for t1 = 1:1:length(t)-1 
    u(t1,:,length(y)) = dx*cos(dt*t1) + u(t1, 2, :);
    u(t1,end,:) = u(t1,end-1,:);  
    u(t1,length(x),:) =  zeros(length(y), 1); 
    u(t1,:,1) = u(t1, :, 2); 
    u(t1, end, 1) = u(t1, end-1, 2); 
    u(t1, 1, 1) = u(t1, 2, 2); 
    u(t1,end,end)= u(t1,end-1,end-1); 
    u(t1, 1, end) = u(t1, 2, end-1); 
    for x1 = 2:1:length(x)-1
        for y1 = 2:1:length(y)-1
            u(t1+1,x1,y1) = D*dt*(u(t1,x1+1,y1) + u(t1,x1-1,y1) + u(t1,x1,y1+1) + u(t1,x1,y1-1) - 4*u(t1,x1,y1))/(dx*dx) + u(t1,x1,y1);
        end
    end
end

surf(squeeze(u(50,:,:)))
zlim([-1 1]);
drawnow;