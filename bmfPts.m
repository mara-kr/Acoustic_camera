function [powerLvls,powerLvlsAvg,row,col] = bmfPts(pCrds,signals,res,...
                                              micSep,aDims,aCrds,fs,temp)
%BmfPts beamformes signals based on point in space
%   BL == bottom Left, TR == Top right, when facing source
%   res = [xres,yres] - determines how often points are sampled(resolution)
%   pCrds = plane Coordinates = [x1,y1,z1;x2,y2,z2] - opp corners(BL-TR)
%   aCrds = array Coordinates = [xa,ya,za] - BL mic crds
%   fs - sampling frequency
%   temp - room temperature in F, needed for speed of sound calculation
%   signals - array of mic signals ordered from bottom left to top right
%   aDims - [arrayWidth,arrayHeight] - Width and height of array in # mics
%   powerLvls - the baseline array of points and power levels
%   powerLvlsAvg - powerLvls with the average removed from every point
%   [row,col] describes the point with the maximum power level
%   UNITS == INCHES BY DEFAULT. TO SWITCH TO ANOTHER UNIT, CHANGE LINE 22
%   mCoords - array of the coordinates of mics; mCoords(1)=mic1, etc
xres = res(1);
yres = res(2);
zp = pCrds(1,3);
arrayWidth = aDims(1);
arrayHeight = aDims(2);
vs = speedSound(temp,'in/s');
numMics = arrayWidth*arrayHeight;
xa = aCrds(1);
ya = aCrds(2);
za = aCrds(3);
sampLength = length(signals(:,1));
mCrds = zeros(numMics,3);%coordinates of each mic

%creates size of powerLvls array, so it doesn't keep changing size
plx = (pCrds(end,1)-pCrds(1,1))/xres + 1;
ply = (pCrds(end,2)-pCrds(1,2))/yres + 1;
assert(floor(plx)==plx)%iterating through x should hit start and end
assert(floor(ply)==ply)%iterating through y should hit start and end
powerLvls = zeros(ply,plx);%rows are y, cols are x (line 63 as well)
assert(pCrds(1,3)==pCrds(2,3))
assert(xa>pCrds(1,1) && xa<pCrds(end,1))%mic array must be inside plane
assert(ya>pCrds(1,2) && ya<pCrds(end,2))
assert(za<pCrds(1,3))%plane of interest is in front of mic array

for mic = 1:numMics%creates mCoords array
    mCrds(mic,2) = ya+(floor((mic-1)/arrayWidth))*micSep;%m1@botL-facing
    mCrds(mic,1) = xa+(mod(mic-1,arrayWidth))*micSep;
    mCrds(mic,3) = za;%array is in xy plane, z coord is cst.
end

xmid = (mCrds(1,1)+mCrds(end,1))/2;
ymid = (mCrds(1,2)+mCrds(end,2))/2;
zmid = za;
midCrds = [xmid,ymid,zmid];%middle of mic array coordinates

for xp=pCrds(1,1):xres:pCrds(end,1)
    for yp=pCrds(1,2):yres:pCrds(end,2)
        signalSum = zeros(sampLength,1);
        for mic=1:numMics
            delay = calcDelayPts(fs,vs,xp,yp,zp,mic,mCrds,midCrds);
            silence = zeros(abs(delay),1);
            if delay <= 0
                mDSilence = [silence;signals(1:end,mic)];
                micDelayed = mDSilence(1:sampLength,1);
            else
                mDSilence = [signals(1:end,mic);silence];
                micDelayed = mDSilence(delay+1:end,1);
            end
            signalSum = signalSum + micDelayed;
        end
        xind = (xp-pCrds(1,1))/xres + 1;
        yind = (yp-pCrds(1,2))/yres + 1;
        powerLvls(yind,xind) = bandpower(signalSum);
    end
end

% Removes average from every point
[rows,cols]=size(powerLvls);
avg = (sum(sum(powerLvls)))/(rows*cols);
powerLvlsAvg = powerLvls;
for row=1:rows
    for col=1:cols
        if powerLvlsAvg(row,col)>avg
            powerLvlsAvg(row,col) = powerLvlsAvg(row,col)-avg;
        else
            powerLvlsAvg(row,col) = 0;
        end
    end
end

[row,col] = find(max(max(powerLvls))==powerLvls);
end

