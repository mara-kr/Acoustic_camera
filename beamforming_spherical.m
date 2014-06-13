micArray = [1 2; 3 4];
signals = [mic1,mic3,mic2,mic4];
micSep = .253;
degRes = 5; %Change to change resolution, MUST use factors of 90,180
fs = 44100; %sampling frequency
v = 344; %speed of sound
power_lvls = zeros(floor(180/degRes)-1, floor(180/degRes)-1);
assert(90/degRes == floor(90/degRes))

for p = 0+degRes:degRes:180-degRes%p=phi
    if p/10==floor(p/10)
        disp(p)
    end
    for t = degRes:degRes:180-degRes%t-theta
        signalSum = zeros(1,length(mic1));
        if t~=90
            mics = micArray;%mics is the mics of interest
            if t<90 && p<90
                last = mics(end,1);%which mic sound hits last
            elseif t>90 && p<90
                last = mics(end,end);
            elseif t<90 && p>90
                last = mics(1,1);
            elseif t>90 && p>90
                last = mics(1,end);
            end
            for j = 1:numel(mics)%number of mics of interset
                mic = mics(j);
                if mic~=last
                    delay=calcDelay2dS(p,t,mics,mic,last,fs,v,micSep);
                    micDelayed=fracFilter(signals(1:end,mic),delay);
                else
                    micDelayed=signals(1:end,mic);
                end
                for i=1:length(mic1)
                    signalSum(i) = signalSum(i) + micDelayed(i);
                end
            end
        else%theta=90 case
            ncols = size(micArray,2);
            for col=1:ncols
                mics=micArray(:,col);
                if p<0
                    last = mics(end);
                else
                    last = mics(1);
                end
                for j = 1:numel(mics)
                    mic = mics(j);
                    if mic~=last
                        delay=calcDelay2dS(p,t,mics,mic,last,fs,v,micSep);
                        micDelayed=fracFilter(signals(1:end,mic),delay);
                    else
                        micDelayed = signals(1:end,mic);
                    end
                    for i = 1:length(mic1)
                        signalSum(i) = signalSum(i) + micDelayed(i);
                    end
                end
            end
        end
        if p~=0
            power_lvls(p/degRes,t/degRes)=bandpower(signalSum,fs,[200,20000]);
        else
            power = bandpower(signalSum,fs,[200,20000]);
            for i=1:length(power_lvls)
                power_lvls(90/degRes,i) = power;
            end
        end
    end
end
            
                    