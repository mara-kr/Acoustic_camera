function [signals] = selectMicData(numMics)
%SelectMicData is a tool for importing mic data into a signals array that
%    can be passed to beamforming scripts/functions
%    It's listed elsewhere, but mic1 is the bottom left mic when facing
%    the array, mic2 is to the right of mic1, and so on. The last mic is
%    the top right mic.
currentFolder = pwd;%current matlab directory
disp('Select the signal for the 1st mic!')
[fname,path] = uigetfile('.wav');
if ischar(fname)
    data = audioread(strcat(path,fname));
    signals = zeros(length(data),numMics);
    signals(:,1) = data;
    cd(path)%sets current directory to where first file was found
    for mic = 1:numMics-1
        switch mic
            case 1
                disp('Select the signal for the 2nd mic!');
            case 2
                disp('Select the signal for the 3rd mic!');
            otherwise
                fprintf('Select the signal for the %dth mic!\n',mic+1)
        end
        [fname,path] = uigetfile('.wav');
        if ischar(fname)
            data = audioread(strcat(path,fname));
            if length(data)==size(signals,1)
                signals(:,mic+1) = data;
            else
                cd(currentFolder)
                error('Signals must be the same length')
            end
        end
    end
end
cd(currentFolder)
if signals(1,end)==0
    error('Did not select enough mic Data!')
end

