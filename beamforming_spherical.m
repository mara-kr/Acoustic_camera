%sim mic_input_2d
%mics oriented the way they look facing them
mics = [2 1;4 3];%bug with mics=[1 2;6 5]
signals = [mic2 mic4 mic1,mic3];
micSep = .222;
degRes = 5; %Change to change resolution, MUST use factors of 90,180
fs = 96000; %sampling frequency
v = 344.2; %speed of sound
powerLvls = zeros(floor(180/degRes)-1, floor(180/degRes)-1)-1;
assert(90/degRes == floor(90/degRes))

for p=0+degRes:degRes:180-degRes%p-phi, skips 0,180
    if (p/10)==floor(p/10)%to show progress
        disp(p)
    end
    for t=0+degRes:degRes:180-degRes%t-theta
        signalSum = zeros(1,length(mic1));
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
                hdint = dfilt.delay(floor(delay));
                micDelayed = filter(hdint,signals(1:end,j));
            else
                micDelayed = signals(1:end,j);%mic & signal at same index
            end
            for i=1:length(mic1)
                signalSum(i)=signalSum(i)+micDelayed(i);
            end
        end
        powerLvls(p/degRes,t/degRes)=bandpower(signalSum,fs,[200,20000]);
    end
end

%Removes average from every point
[rows,cols]=size(powerLvls);
total = 0;
for row=1:rows
    for col=1:cols
        total = total + powerLvls(row,col);
    end
end
avg = total/(rows*cols);
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
clear hdint degRes rows cols total tout v