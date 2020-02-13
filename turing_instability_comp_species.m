% Turing instability in the Competing Species Model
% Code for Deterministic Modeling class 2020

clear all
dt = 0.001;
dx = 0.03;
dy = 0.03;
T = 100;
x = 0:dx:1;
t = 0:dt:T;
y = 0:dy:1;
% const
d = 0.1;
D = 0.01;
% linear population growth
r1 = 2;
r2 = 0.4;

% alfa1 * alfa2 < 1 to have stable state
alfa1 = 0.5;
alfa2 = 2.4;


u = zeros(length(t), length(x), length(y)); 
v = zeros(length(t), length(x), length(y)); 

% initial condition
 v(1, :, :) = (1 - alfa1)/(1-alfa1*alfa2);
 u(1, 20, 20) = (1 - alfa2)/(1-alfa1*alfa2) + 0.02;

for t1 = 1:1:length(t)-1
    % von Neumann Conditions
    % left
    u(t1, :, 1) = u(t1, :, 2);
    v(t1, :, 1) = v(t1, :, 2);
    
    % bottom
    u(t1, end, :) = u(t1, end-1, :);
    v(t1, end, :) = v(t1, end-1, :);
    
    % right
    u(t1, :, end) = u(t1, :, end-1);
    v(t1, :, end) = v(t1, :, end-1);
    
    % top
    u(t1, 1, :) = u(t1, 2, :);
    v(t1, 1, :) = v(t1, 2, :);
    
    % corners
    % top left
    u(t1, 1, 1) = u(t1, 2, 2);
    v(t1, 1, 1) = v(t1, 2, 2);
    
    % bottom right
    u(t1, end, end) = u(t1, end-1, end-1);
    v(t1, end, end) = v(t1, end-1, end-1);
    
    % bottom left
    u(t1, end, 1) = u(t1, end-1, 2);
    v(t1, end, 1) = v(t1, end-1, 2);
    
    % top right
    u(t1, 1, end) = u(t1, 2, end-1);
    v(t1, 1, end) = v(t1, 2, end-1);
    
    
    for x1 = 2:1:length(x)-1
        for y1 = 2:1:length(y)-1
            u(t1+1,x1,y1) = dt*(d*(u(t1,x1+1,y1) + u(t1,x1-1,y1) + u(t1,x1,y1+1) + u(t1,x1,y1-1) - 4*u(t1,x1,y1))/(dx*dx) + r1*u(t1,x1,y1)*(1 - u(t1,x1,y1) - alfa2* v(t1,x1,y1))) +u(t1,x1,y1);
            v(t1+1,x1,y1) = dt*(D*(v(t1,x1+1,y1) + v(t1,x1-1,y1) + v(t1,x1,y1+1) + v(t1,x1,y1-1) - 4*v(t1,x1,y1))/(dx*dx) + r2*v(t1,x1,y1) * (1 - alfa1*u(t1,x1,y1) - v(t1,x1,y1)))+v(t1,x1,y1);
        end
        
    end
end

 for k = 1:50:length(t)-1
    subplot(1,2,1)
    
    surf(squeeze(u(k,:,:)))
    title("Gatunek 1")
    shading flat
    view(2)
    subplot(1,2,2)
    surf(squeeze(v(k,:,:)))
    title("Gatunek 2")
    view(2)
    shading flat
    drawnow
  end