function [data] = importMics()
%Takes files made by Audacity multiple export and saves signals in .mat
dir = strcat(uigetdir(),'/');
if strcmp(dir,'/')%user canceled dlg
    data = 0;
    return
end
if exist(strcat(dir,'m-38.wav'),'file') 
    names = {'m-21.wav';'m-22.wav';'m-23.wav';'m-24.wav';'m-25.wav';...
        'm-26.wav';'m-27.wav';'m-28.wav';'m-31.wav';'m-32.wav';...
        'm-33.wav';'m-34.wav';'m-35.wav';'m-36.wav';'m-37.wav';...
        'm-38.wav';'m-01.wav';'m-02.wav';'m-03.wav';'m-04.wav';...
        'm-05.wav';'m-06.wav';'m-07.wav';'m-08.wav';'m-11.wav';...
        'm-12.wav';'m-13.wav';'m-14.wav';'m-15.wav';'m-16.wav'};
    skipped = {'m-09.wav';'m-10.wav';'m-17.wav';'m-18.wav';...
               'm-19.wav';'m-20.wav';'m-29.wav';'m-30.wav'};
else
    names = {'m-15.wav';'m-16.wav';'m-17.wav';'m-18.wav';'m-19.wav';...
        'm-20.wav';'m-21.wav';'m-22.wav';'m-23.wav';'m-24.wav';...
        'm-25.wav';'m-26.wav';'m-27.wav';'m-28.wav';'m-29.wav';...
        'm-30.wav';'m-01.wav';'m-02.wav';'m-03.wav';'m-04.wav';...
        'm-05.wav';'m-06.wav';'m-07.wav';'m-08.wav';'m-09.wav';...
        'm-10.wav';'m-11.wav';'m-12.wav';'m-13.wav';'m-14.wav'};
end
sigLen = length(audioread(strcat(dir,'m-15.wav')));
signals = zeros(sigLen,30);
for i=1:length(names)
    signals(:,i) = audioread(strcat(dir,names{i}));
end
[fname,path] = uiputfile('*.mat','Save As');
if fname==0 %user canceled dlg
    data=0;
    return
end
save(strcat(path,fname),'signals')
for i=1:length(names)
    delete(strcat(dir,'/',names{i}));
end
if exist('skipped','var')
    for i=1:length(skipped)
        delete(strcat(dir,'/',skipped{i}));
    end
end
data = signals;
end