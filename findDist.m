function [dist] = findDist(mics, mic, last, micSep)
%Finds the real world distance from mic to last (also a mic), both as nums
[lrow,lcol] = find(mics == last);
[mrow,mcol] = find(mics == mic);
drow = abs(lrow-mrow);
dcol = abs(lcol-mcol);
xdist = dcol*micSep;
ydist = drow*micSep;
if xdist==0 || ydist==0
    dist = xdist+ydist;
else
    dist = (xdist^2+ydist^2)^.5;
end