%Diffusion equation on line segment

clear all
dt = 0.001;
dx = 0.1;
x = 0:dx:1;
t = 0:dt:1;
bottom = sin(pi*x);
matrix = zeros(length(t), length(bottom));
matrix(end, :) = bottom;
D = 0.5;
for t1 = length(t)-1:-1:1
    for x1 = 2:1:length(x)-1
        matrix(t1,x1) = dt*D*(matrix(t1+1, x1+1) + matrix(t1+1, x1-1) - 2*matrix(t1+1, x1))/(dx^2) + matrix(t1+1, x1);
    end
    matrix(t1, 1) = matrix(t1, 2);
    matrix(t1, end) = cos(dt * t1);
end

surf(matrix);
drawnow;