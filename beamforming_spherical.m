%sim mic_input_2d
%mics oriented the way they look facing them
mics = [1 2 3;6 5 4];
signals = [mic1 mic6 mic2 mic5 mic3 mic4];
micSep = .19;
degRes = 5; %Change to change resolution, MUST use factors of 90,180
fs = 44100; %sampling frequency
v = round(speedSound(71,'m/s')); %speed of sound
powerLvls = zeros(floor(180/degRes)-1, floor(180/degRes)-1)-1;
assert(90/degRes == floor(90/degRes))
sampLength = length(mic1);%how many samples each signal is

for p=0+degRes:degRes:180-degRes%p-phi, skips 0,180
%     if (p/30)==floor(p/30)%to show progress
%         disp(p)
%     end
    for t=0+degRes:degRes:180-degRes%t-theta
        signalSum = zeros(length(mic1),1);
        if t<90 && p<90
            last = mics(end,1);%which mic sound hits last
        elseif t<90 && p>90
            last = mics(1,1);
        elseif t>90 && p<90
            last = mics(end,end);
        elseif t>90 && p>90
            last = mics(1,end);
        elseif t==90 && p<90
            last = mics(end,end);
        elseif t==90 && p>90
            last = mics(1,1);
        elseif t<90 && p==90
            last = mics(1,1);
        elseif t>90 && p==90
            last = mics(end,end);
        end
        for j = 1:numel(mics)
            mic = mics(j);
            if mic~=last
                delay = calcDelay2dS(p,t,mics,mic,last,fs,v,micSep);
                silence = zeros(delay,1);
                micDelaySilence = [silence;signals(1:end,j)];
                micDelayed = micDelaySilence(1:sampLength,1);
                clear micDelaySilence silence delay
            else
                micDelayed = signals(1:end,j);%mic & signal at same index
            end
            signalSum = signalSum + micDelayed;
        end
%         powerLvls(p/degRes,t/degRes) = signalSum(floor(sampLength/4)+100);
        powerLvls(p/degRes,t/degRes) = bandpower(signalSum);
        %had bandpower(signalSum,fs,[800,20000])
    end
end

%Removes average from every point
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
clear row col
[row,col] = find(max(max(powerLvls))==powerLvls);
clear delay fs i j last mic micSep mics p t signalSum signals micDelayed
clear degRes rows cols total tout v micDelaySilence sampLength silence