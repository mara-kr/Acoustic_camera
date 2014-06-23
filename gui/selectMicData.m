%SelectMicData is a tool for importing mic data into a signals array that
%    can be passed to beamforming scripts/functions
%    It's listed elsewhere, but mic1 is the bottom left mic when facing
%    the array, mic2 is to the right of mic1, and so on. The last mic is
%    the top right mic.
currentFolder = pwd;%current matlab directory
numMics = 6;
[fname,path] = uigetfile('.wav');
data = audioread(strcat(path,fname));
signals = zeros(length(data),numMics);
signals(:,1) = data;
cd(path)%sets current directory to where first file was found
for mic = 1:numMics-1
    [fname,path] = uigetfile('.wav');
    data = audioread(strcat(path,fname));
    signals(:,mic+1) = data;
end
cd(currentFolder)
save('signals.mat','signals');