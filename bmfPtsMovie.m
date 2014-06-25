function [m] = bmfPtsMovie(pCrds,signals,res,micSep,aDims,aCrds,fs,...
                           temp,frameLength)
%bmfPtsMovie creates a movie with each frame using frameLength samples
%   Detailed explanation goes here
nFrames = ceil(length(signals(:,1))/frameLength);
h = figure('Renderer','zbuffer','NextPlot','replacechildren',...
       'Units','pixels','Position',[100,100,800,700]);
fprintf('1 frame out of %d\n',nFrames)
firstSig = signals(1:frameLength,:);
[~,avg] = bmfPts(pCrds,firstSig,res,micSep,aDims,aCrds,fs,temp);
surf(avg)
zlim([0,.12]);%arbitraryish. Mostly just needs to be fixed.
m(1) = getframe(h);
axis tight
for i = 2:nFrames
    fprintf('%d frame out of %d\n',i,nFrames)
    if i~=nFrames
        data = signals(frameLength*(i-1)+1:frameLength*i,:);
    else
        data = signals(frameLength*(i-1)+1:end,:);
    end
    [~,avg] = bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp);
    surf(avg)
    zlim([0,.12])
    m(i) = getframe(h); %#ok<AGROW>
end
close all
end

