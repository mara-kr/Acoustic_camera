function [dist,angle] = findDist(row1,col1,row2,col2, micSep)
%Finds the distance from mic to last mic, both as nums + path angle
drow = abs(row1-row2);
dcol = abs(col1-col2);
xdist = dcol*micSep;
ydist = drow*micSep;
if xdist==0 || ydist==0
    dist = xdist+ydist;
    angle = 0;
else
    dist = (xdist^2+ydist^2)^.5;
    angle = atan(ydist/xdist);
end