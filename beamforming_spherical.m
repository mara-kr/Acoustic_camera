%mics oriented the way they look facing them
mics = [1 2; 3 4];
signals = [mic1,mic3,mic2,mic4];
micSep = .253;
degRes = 5; %Change to change resolution, MUST use factors of 90,180
fs = 44100; %sampling frequency
v = 344; %speed of sound
power_lvls = zeros(floor(180/degRes)-1, floor(180/degRes)-1)-1;
assert(90/degRes == floor(90/degRes))

for p=0+degRes:degRes:180-degRes%p-phi, skips 0,180
    if (p/10)==floor(p/10)%to show progress
        disp(p)
    end
    for t=0+degRes:degRes:180-degRes%t-theta
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
        power_lvls(p/degRes,t/degRes)=bandpower(signalSum,fs,[200,20000]);
    end
end                 