clear all
close all
sim mic_input_2d
microphones = [1 2; 3 4];
signals = [mic1,mic3,mic2,mic4];
num_mics = 4;
micSep = .1;
deg_res = 10; %Change to change resolution, MUST use factors of 90,180
sampR = 44100; %sampling rate
speed = 345; %speed of sound
power_lvls = zeros(floor(180/deg_res)+1, floor(180/deg_res)+1);
assert(90/deg_res == floor(90/deg_res))

for phi = -90+deg_res:deg_res:0-deg_res%excludes phi=-90
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
            if mic~=last%pb - when mics~=microphones might miss index
                delay=calcDelay2d(phi,theta,mics,mic,last,sampR,speed,micSep);
                hdint = dfilt.delay(floor(delay));
                dfrac = fdesign.fracdelay(delay-floor(delay));
                hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
                micDelayed=filter(hdfrac,filter(hdint,signals(1:end,mic)));
            else
                micDelayed=signals(1:end,mic);
            end
            for i = 1:length(mic1)%sums mic signals
                signalSum(i) = signalSum(i) + micDelayed(i);
            end
            pind = (phi+90)/deg_res;%phi adjusted to index into array
            tind = theta/deg_res; %theta adj. to index into array
            power_lvls(pind,tind)=bandpower(signalSum,sampR,[200,20000]);
        end
    end
end

disp('half')
signalSum = zeros(1,length(mic1));
for mic=1:num_mics %case where phi=90
    for i=1:length(mic1)
        signalSum(i) = signalSum(i)+signals(i,mic);
    end
end
power_lvls(90/deg_res,1) = bandpower(signalSum,sampR,[200,20000]);

for phi = 0+deg_res:deg_res:90-deg_res%excludes phi=90
    for theta = deg_res:deg_res:180-deg_res%excludes theta=0,180
        signalSum = zeros(1,length(mic1));
        if theta<90 %Cannot be 0
            mics = microphones;%mics is the mics of interest
            last = mics(1,end);
        elseif theta>90 %Cannot be 180
            mics = microphones;
            last = mics(end,end);
        elseif theta == 90
            mics = microphones(1,:);
            last = mics(end);
        end
        for mic = 1:numel(mics)%number of mics of interest
            if mic~=last
                delay=calcDelay2d(phi,theta,mics,mic,last,sampR,speed,micSep);
                hdint = dfilt.delay(floor(delay));
                dfrac = fdesign.fracdelay(delay-floor(delay));
                hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
                micDelayed=filter(hdfrac,filter(hdint,signals(1:end,mic)));
            else
                micDelayed=signals(1:end,mic);
            end
            for i = 1:length(mic1)%sums mic signals
                signalSum(i) = signalSum(i) + micDelayed(i);
            end
            pind = (phi+90)/deg_res;%phi adjusted to index into array
            tind = theta/deg_res; %theta adj. to index into array
            power_lvls(pind,tind)=bandpower(signalSum,sampR,[200,20000]);
        end
    end
end
clear dfrac hdfrac hdint delay i last mic micDelayed mics phi theta signals
clear signalSum speed tout