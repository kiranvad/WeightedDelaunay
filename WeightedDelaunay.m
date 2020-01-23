% A MATLAB function to compute weighted delaunay triangulation of a point
% cloud.
% INPUTS:
% ------
%       points      :   number of points X dimensions (point cloud as input)
%       weights     :   number of points X 1 (weights as a vector)
% OUTPUTS:
% --------
%       cells       :   Triangulated faces. Each row is a triangle 
%       lifted      :   Lifted coordinates of to compute convex-hull on a paraboloid
%
% (c) Copyright Kiran Vaddi 2020

function [cells, lifted] = WeightedDelaunay(points,weights)

[num,dim] = size(points);

lifted = zeros(num,dim+1);

for i = 1:num
    p = points(i,:);
    lifted(i,:) = [p (sum(p.^2) - weights(i)^2)];
end

pinf = [zeros(1,dim) 1e10];
lifted = [lifted;pinf];
cells_old = convhulln(lifted);
cells = [];
for i = 1:size(cells_old,1)
    c = cells_old(i,:);
    if ~ismember(num+1,c)
        cells= [cells;c];
    end
end

end