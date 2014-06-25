res = [5,5];%xres,yres
fs = 44100;
temp = 71;
micSep = 8;
pCrds = [0,0,90;175,175,90];
aDims = [3,2];%width,height
aCrds = [70,35,0];
%signals = [mic1 mic2 mic3 mic4 mic5 mic6];
frameL = 3675;%length of movie frame in samples

nFrames = ceil(length(signals(:,1))/frameL);
h = figure('Renderer','zbuffer','NextPlot','replacechildren',...
       'Units','pixels','Position',[100,100,800,700]);
fprintf('1 frame out of %d\n',nFrames)
firstSig = signals(1:frameL,:);
[powerlvls,avg] = bmfPts(pCrds,firstSig,res,micSep,aDims,aCrds,fs,temp);
surf(avg)
zlim([0,.12]);
m(1) = getframe(h);
axis tight
for i = 2:nFrames
    fprintf('%d frame out of %d\n',i,nFrames)
    if i~=nFrames
        data = signals(frameL*(i-1)+1:frameL*i,:);
    else
        data = signals(frameL*(i-1)+1:end,:);
    end
    [powerlvls,avg] = bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp);
    surf(avg)
    zlim([0,.12])
    m(i) = getframe(h);
end
close all
clear aCrds aDims data firstSig frameL fs micSep nFrames pCrds res temp i h
clear powerlvls avg