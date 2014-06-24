res = [5,5];%xres,yres
fs = 44100;
temp = 71;
micSep = 7.48;
aDims = [3,2];%width,height
pCrds = [0,0,100;300,300,100];
aCrds = [150,150,10];
%signals = [mic1 mic2 mic3 mic4 mic5 mic6];
frameL = 50;%length of movie frame in samples

nFrames = ceil(length(signals(:,1))/frameL);
h = figure('Renderer','zbuffer','NextPlot','replacechildren',...
       'Units','pixels','Position',[100,100,800,700]);
fprintf('1 frame out of %d\n',nFrames)
firstSig = signals(1:frameL,:);
contour(bmfPts(pCrds,firstSig,res,micSep,aDims,aCrds,fs,temp))
m(1) = getframe(h);
axis tight
for i = 2:nFrames
    fprintf('%d frame out of %d\n',i,nFrames)
    if i~=nFrames
        data = signals(frameL*(i-1)+1:frameL*i,:);
    else
        data = signals(frameL*(i-1)+1:end,:);
    end
    contour(bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp))
    m(i) = getframe(h); %#ok<SAGROW>
end
close all
clear aCrds aDims data firstSig frameL fs micSep nFrames pCrds res temp i h
figure('Position',[100,100,900,750])
waitforbuttonpress
movie(m)
waitforbuttonpress
movie(m,1,6)
waitforbuttonpress
movie(m)