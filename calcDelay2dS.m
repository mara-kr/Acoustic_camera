function [numSamples] = calcDelay2dS(p,t,mics,mic1,mic2,fs,v,micSep)
%CalcDelay based on spherical cords formula
%   At any given point, the sound plane is tangent to a sphere centered
%   at the origin. This plane includes mic1.
p_rads = degtorad(p);%p-phi
t_rads = degtorad(t);%t-theta
sampTime = 1/fs;
[row1,col1] = find(mics == mic1);
[row2,col2] = find(mics == mic2);
dx = abs(col1-col2)*micSep;%only care about absolute distance
dy = abs(row1-row2)*micSep;
f = sin(p_rads)*cos(t_rads);%normal vector to plane is (f,g,h)
g = sin(p_rads)*sin(t_rads);
h = cos(p_rads);
dist = (abs(f*dx + g*dy + h))/(f^2 + g^2 + h^2);%dist from pt to plane formula
time = dist/v;
numSamples = time/sampTime;
end

