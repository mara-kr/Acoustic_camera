%PCoords describe the plane of interest - assumes parallel to xy plane
%order signals array counting from botL(facing) to topR so m1 at signals(1)
pCoords = [0 0 96; 200 200 96];%(x1,y1,z1;x2,y2,z2) opp corners
assert(pCoords(1,3)==pCoords(2,3))
zp = pCoords(1,3);
signals = [mic4 mic5 mic6 mic3 mic2 mic1];%each mic signal is col vector
xres = 5;
yres = 5;
micSep = 8; %in inches
arrayWidth = 3; %in mics
arrayHeight = 2;
xa = 90;%x coord of bot-left array corner
ya = 90;%y coord of bot-left array corner
za = 0;%z coordinate of the array
fs = 44100;%sampling rate

vs = speedSound(71,'in/s');%71 is room temp
sampLength = length(mic1); 
numMics = arrayWidth*arrayHeight;
mCoords = zeros(numMics,3);

plx = (pCoords(end,1)-pCoords(1,1))/xres + 1;
ply = (pCoords(end,2)-pCoords(1,2))/yres + 1;
assert(floor(plx)==plx)%iterating through x should hit start and end
assert(floor(ply)==ply)%iterating through y should hit start and end
powerLvls = zeros(ply,plx);%rows are y, cols are x (line 56 as well)
for mic=1:numMics%creates mCoords array
    mCoords(mic,2) = ya+(floor((mic-1)/arrayWidth))*micSep;%m1@botL-facing
    mCoords(mic,1) = xa+(mod(mic-1,arrayWidth))*micSep;
    mCoords(mic,3) = za;%array is in xy plane, z coord is cst.
end

xmid = (mCoords(1,1)+mCoords(end,1))/2;
ymid = (mCoords(1,2)+mCoords(end,2))/2;
zmid = za;
midCoords = [xmid,ymid,zmid];

for xp=pCoords(1,1):xres:pCoords(end,1)
    for yp=pCoords(1,2):yres:pCoords(end,2)
        signalSum = zeros(length(mic1),1);
        for mic=1:numMics
            delay = calcDelayPts(fs,vs,xp,yp,zp,mic,mCoords,midCoords);
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
        xind = (xp-pCoords(1,1))/xres + 1;
        yind = (yp-pCoords(1,2))/yres + 1;
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
clear xp yp zp xa ya za fs xres yres micSep arrayWidth numMics sampLength
clear arrayHeight signals micDelayed mCoords mDSilence mic delay silence
clear plx ply pCoords midCoords xind xmid yind ymid zmid vs signalSum
clear cols avg rows