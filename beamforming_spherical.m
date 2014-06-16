%sim mic_input_2d
%mics oriented the way they look facing them
mics = [2 1;4 3];
signals = [mic2,mic4,mic1,mic3];
micSep = .22;
degRes = 5; %Change to change resolution, MUST use factors of 90,180
fs = 44100; %sampling frequency
v = 345; %speed of sound
powerLvls = zeros(floor(180/degRes)-1, floor(180/degRes)-1)-1;
assert(90/degRes == floor(90/degRes))

for p=0+degRes:degRes:180-degRes%p-phi, skips 0,180
    if (p/10)==floor(p/10)%to show progress
        disp(p)
    end
    for t=0+degRes:degRes:180-degRes%t-theta
        signalSum = zeros(1,length(mic1));
        if t<90 && p<90 %CORRECT/ADD FOR NEW PHI/THETA DEF-done
            last = mics(end,1);%which mic/mics sound hits last
        elseif t<90 && p>90
            last = mics(1,1);
        elseif t>90 && p<90
            last = mics(end,end);
        elseif t>90 && p>90
            last = mics(1,end);
        elseif t==90 && p<90
            last = mics(end,1);
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
                micDelayed=fracFilter(signals(1:end,mic),delay);
            else
                micDelayed=signals(1:end,mic);
            end
            for i=1:length(mic1)
                signalSum(i)=signalSum(i)+micDelayed(i);
            end
        end
        powerLvls(p/degRes,t/degRes)=bandpower(signalSum,fs,[200,20000]);
    end
end
[rows,cols]=size(powerLvls);
total = 0;
for row=1:rows
    for col=1:cols
        total = total + powerLvls(row,col);
    end
end
avg = total/(rows*cols);
for row=1:rows
    for col=1:cols
        if powerLvls(row,col)>avg
            powerLvls(row,col) = powerLvls(row,col)-avg;
        else
            powerLvls(row,col) = 0;
        end
    end
end
clear delay fs i j last mic micSep mics p t signalSum signals micDelayed
clear hdint degRes row rows col cols total tout v