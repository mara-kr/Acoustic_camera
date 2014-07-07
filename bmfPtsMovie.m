function [m] = bmfPtsMovie(pCrds,signals,res,micSep,aDims,aCrds,fs,...
                           temp,frameLength)
%bmfPtsMovie creates a movie with each frame using frameLength samples
%   Detailed explanation goes here
nFrames = ceil(length(signals(:,1))/frameLength);
m = struct('cdata', cell(1,nFrames), 'colormap', cell(1,nFrames));
for  i = 1:nFrames
    fprintf('%d frame out of %d\n',i,nFrames)
    if i~=nFrames
        data = signals(frameLength*(i-1)+1:frameLength*i,:);
    else
        data = signals(frameLength*(i-1)+1:end,:);
    end
    [~,avg] = bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp);
    surf(avg)
    zlim([0,5])
    m(i) = getframe;
end
end

