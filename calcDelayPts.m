function [numSamples] = calcDelayPts(fs,vs,xp,yp,zp,mic,mCoords,midCoords)
%calcDelayPts find delay for given mic and point in space
%   Taken from "FGPA-based Real Time Acoustic Camera Prototype" by
%   B.Zimmermann and C.Studer (Citation Below)
% Zimmermann, B., and C. Studer. 
% "FPGA-based Real-Time Acoustic Camera Prototype." 
% Proceedings of 2010 IEEE International Symposium on Circuits and Systems 
% (ISCAS) (2010): 1419-422. IEEE Xplore. IEEE.org, 2010. Web. 18 June 2014.
xm = mCoords(mic,1);
ym = mCoords(mic,2);
zm = mCoords(mic,3);
xmid = midCoords(1);
ymid = midCoords(2);
zmid = midCoords(3);
midDist = ((xp-xmid)^2 + (yp-ymid)^2 + (zp-zmid)^2)^.5;
midDelay = (fs/vs)*midDist;
dist = ((xp-xm)^2 + (yp-ym)^2 + (zp-zm)^2)^.5;
delay = (fs/vs)*dist;
numSamples = round(delay-midDelay);
end