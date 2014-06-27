%requires signals in workspace
res = [5,5];%xres,yres
fs = 44100;
temp = 71;
micSep = 8;
pCrds = [0,0,90;180,180,90];
aDims = [3,2];%width,height
aCrds = [70,35,0];
frameL = 3675;%length of movie frame in samples

nFrames = ceil(length(signals(:,1))/frameL);
m = struct('cdata', cell(1,nFrames), 'colormap', cell(1,nFrames));
h = figure('Renderer','zbuffer','NextPlot','replacechildren',...
           'Units','pixels','Position',[100,100,500,400],...
           'Visible','off');
w = waitbar(0,'Please Wait...','Position',[700,500,300,50]);
for i = 1:nFrames
    waitbar(i/nFrames,w)
    fprintf('%d frame out of %d\n',i,nFrames)
    if i~=nFrames
        data = signals(frameL*(i-1)+1:frameL*i,:);
    else
        data = signals(frameL*(i-1)+1:end,:);
    end
    [~,avg] = bmfPts(pCrds,data,res,micSep,aDims,aCrds,fs,temp);
    surf(avg)
    zlim([0,.05])
    m(i) = getframe(h);
end
close all
clear aCrds aDims data firstSig frameL fs micSep nFrames pCrds res temp i h
clear powerlvls avg w