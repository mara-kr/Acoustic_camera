function [powerLvls] = bmfPts(pCrds,signals,res,micSep,aDims,aCrds,fs)
%Beamforming_points beamformes signals based on point in space
%   res = [xres,yres] aDims = [arrayWidth,arrayHeight]
%   pCrds = plane Coordinates = [x1,y1,z1;x2,y2,z2] - opp corners
%   aCrds = array Coordinates = [xa,ya,za] - bottom left (facing) mic cords
%   fs - sampling frequency
xres = res(1);
yres = res(2);
zp = pCrds(1,3);
arrayWidth = aDims(1);
arrayHeight = aDims(2);
numMics = arrayWidth*arrayHeight;
vs = speedSound(71,'in/s');%71 is room temp

end

