function [m] = bmfPtsMovie(pCrds,signals,res,micSep,aDims,aCrds,fs,...
                           temp,frameLength)
%bmfPtsMovie creates data for movie with each frame using frameLength
%samples
nFrames = ceil(length(signals(:,1))/frameLength);
h = waitbar(1/nFrames,'Creating Movie...');
data = signals(1:frameLength,:);
[~,avg] = bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp);
[x,y] = size(avg);
m = cell(x,y,nFrames);
m(:,:,1) = num2cell(avg);
for  i = 2:nFrames
    waitbar(i/nFrames,h)
    if i~=nFrames
        data = signals(frameLength*(i-1)+1:frameLength*i,:);
    else
        data = signals(frameLength*(i-1)+1:end,:);
    end
    [~,avg] = bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp);
    m(:,:,i) = num2cell(avg);
end
close(h)
end

