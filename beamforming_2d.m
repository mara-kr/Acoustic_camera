sim mic_input_2d
microphones = [1 2; 3 4];
signals = [mic1; mic2; mic3; mic4];
num_mics = 4;
micSep = .1;
deg_res = 1; %Change to change resolution, MUST use factors of 90,180
sampRate = 44100;
speed = 345; %speed of sound
power_lvls = zeros(floor(180/deg_res)+1, floor(180/deg_res)+1);

for phi = 0:deg_res:90-deg_res
    for theta = deg_res:deg_res:180-deg_res
        signalSum = zeros(1,length(mic1));
        if theta<90 %Cannot be 0
            mics = microphones;%mics is the mics of interest
            last = mics(end,1);
        elseif theta>90 %Cannot be 180
            mics = microphones;
            last = mics(1,1);
        elseif theta == 90
            mics = microphones(1,:);
            last = mics(1);
        end
        for mic = 1:numel(mics)%number of mics of interest
            if mic~=last
                delay=calcDelay2d(phi,theta,mics,mic,last,sampRate,speed,micSep);
                hdint = dfilt.delay(floor(delay));
                dfrac = fdesign.fracdelay(delay-floor(delay));
                hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
                micDelayed=filter(hdfrac,filter(hdint,signals(mic,:)));
            else
                micDelayed=signals(mic,:);
            end
            for i = 1:length(mic1)%sums mic signals
                signalSum(i) = signalSum(i) + micDelayed(i);
            end
            power_lvls(phi,theta)=bandpower(signalSum,sampRate,[200,20000]);
        end
    end
end
signalSum = zero(1,length(mic1));
for mic=1:num_mics %case where phi=90
    for i=1:length(mic1)
        signalSum(i) = signalSum(i)+signals(mic,i);
    end
end
power_lvls(90,0) = bandpower(signalSum,sampRate,[200,20000]);

for phi = 90+deg_res:deg_res:180-deg_res
    for theta = deg_res:deg_res:180-deg_res
        signalSum = zeros(1,length(mic1));
        if theta<90 %Cannot be 0
            mics = microphones;%mics is the mics of interest
            last = mics(end,end);
        elseif theta>90 %Cannot be 180
            mics = microphones;
            last = mics(1,end);
        elseif theta == 90
            mics = microphones(1,:);
            last = mics(end);
        end
        for mic = 1:numel(mics)%number of mics of interest
            if mic~=last
                delay=calcDelay2d(phi,theta,mics,mic,last,sampRate,speed,micSep);
                hdint = dfilt.delay(floor(delay));
                dfrac = fdesign.fracdelay(delay-floor(delay));
                hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
                micDelayed=filter(hdfrac,filter(hdint,signals(mic,:)));
            else
                micDelayed=signals(mic,:);
            end
            for i = 1:length(mic1)%sums mic signals
                signalSum(i) = signalSum(i) + micDelayed(i);
            end
            power_lvls(phi,theta)=bandpower(signalSum,sampRate,[200,20000]);
        end
    end
end