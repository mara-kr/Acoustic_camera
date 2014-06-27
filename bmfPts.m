function [powerLvls,powerLvlsAvg,row,col] = bmfPts(pCrds,signals,res,...
                                              micSep,aDims,aCrds,fs,temp)
%BmfPts beamformes signals based on point in space
%   Assumes mic plane is flat, za==zmid
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
%   Delay formula from "FGPA-based Real Time Acoustic Camera Prototype" by
%   B.Zimmermann and C.Studer (Citation Below) - see for explanation.
%Zimmermann, B., and C. Studer. 
%   "FPGA-based Real-Time Acoustic Camera Prototype." Proceedings of 2010
%   IEEE International Symposium on Circuits and Systems (ISCAS) (2010): 
%   1419-422. IEEE Xplore. IEEE.org, 2010. Web. 18 June 2014.
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
assert(pCrds(1,3)==pCrds(2,3))
assert(xa>pCrds(1,1) && xa<pCrds(end,1))%mic array must be inside plane
assert(ya>pCrds(1,2) && ya<pCrds(end,2))
assert(za<pCrds(1,3))%plane of interest is in front of mic array
plx = (pCrds(end,1)-pCrds(1,1))/xres + 1;
ply = (pCrds(end,2)-pCrds(1,2))/yres + 1;
assert(floor(plx)==plx)%iterating through x should hit start and end
assert(floor(ply)==ply)%iterating through y should hit start and end
powerLvls = zeros(ply,plx);%rows are y, cols are x (line 63 as well)

for mic = 1:numMics%creates mCoords array
    mCrds(mic,2) = ya+(floor((mic-1)/arrayWidth))*micSep;%m1@botL-facing
    mCrds(mic,1) = xa+(mod(mic-1,arrayWidth))*micSep;
    mCrds(mic,3) = za;%array is in xy plane, z coord is cst.
end

xmid = (mCrds(1,1)+mCrds(end,1))/2;
ymid = (mCrds(1,2)+mCrds(end,2))/2;
zd = (zp-za)^2; %for calcDelay equation
coef = fs/vs; %coefficent for calcDelay equation

for xp=pCrds(1,1):xres:pCrds(end,1)
    for yp=pCrds(1,2):yres:pCrds(end,2)
        signalSum = zeros(sampLength,1);
        for mic=1:numMics
            dist = ((xp-mCrds(mic,1))^2+(yp-mCrds(mic,2))^2+zd)^.5;
            midDist = ((xp-xmid)^2+(yp-ymid)^2 + zd)^.5;
            delay = round(coef*(dist-midDist));
            silence = zeros(abs(delay),1);
            if delay <= 0%is there a way to not make mDSilence
                mDSilence = vertcat(silence,signals(:,mic));
                micDelayed = mDSilence(1:sampLength);
            else
                mDSilence = vertcat(signals(:,mic),silence);
                micDelayed = mDSilence(delay+1:end);
            end
            signalSum = signalSum + micDelayed;
        end
        xind = (xp-pCrds(1,1))/xres + 1;
        yind = (yp-pCrds(1,2))/yres + 1;
        powerLvls(yind,xind) = rms(signalSum).^2;
    end
end

% Removes average from every point
[rows,cols]=size(powerLvls);
avg = (sum(sum(powerLvls)))/(rows*cols);
powerLvlsAvg = powerLvls;
for col=1:cols
    for row=1:rows
        if powerLvlsAvg(row,col)>avg
            powerLvlsAvg(row,col) = powerLvlsAvg(row,col)-avg;
        else
            powerLvlsAvg(row,col) = 0;
        end
    end
end

[row,col] = find(max(max(powerLvls))==powerLvls);
end

