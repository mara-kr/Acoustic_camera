function [numSamples] = calcDelay2dS(p,t,mics,mic1,mic2,fs,v,micSep)
%CalcDelay based on spherical cords formula
%   At any given point, the sound plane is tangent to a sphere centered
%   at the origin. This plane includes variable mic1. THis finds the 
%	perpinduclar distance (which is the shortest distance) from the 
%	plane to variable mic2. The mic array is in the xy plane.
p_rads = degtorad(p);%p-phi - angle from the +y-axis
t_rads = degtorad(t);%t-theta - angle +x-axis. t=90:+z-axis
sampTime = 1/fs;
[row1,col1] = find(mics == mic1);
[row2,col2] = find(mics == mic2);
dx = (col1-col2)*micSep;
dy = (row1-row2)*micSep;
a = sin(p_rads)*cos(t_rads);%x-component of normal vector
b = cos(p_rads);%y-component of normal vector
dist = abs(a*dx + b*dy);%dist from pt to plane-simplified
time = dist/v;
numSamples = round(time/sampTime);
end