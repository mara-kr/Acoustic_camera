sim mic_input_2source
signals = [mic1 mic2 mic3 mic4 mic5 mic6 mic7 mic8 mic9 mic10];   
num_mics = 10;
micSep = .1; %Separation between microphones
deg_res = 1; %Change to change resolution, MUST use factors of 90,180
power_lvls = zeros(1,floor(180/deg_res)+1);
samp_rate = 44100;
speed = 345; %speed of sound

%Iterates from [0,90]
for degree = 0:deg_res:(floor(90/deg_res)*deg_res)
    signal_sum = zeros(1,length(mic1));
    for mic = 1:num_mics-1 %assumes sound hits signals(1) first
        delay = calcDelay(degree,micSep,samp_rate,speed)*(num_mics - mic);
        hdint = dfilt.delay(floor(delay));%integer delay filter
        dfrac = fdesign.fracdelay(delay-floor(delay));%fractional delay
        hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
        mic_delayed = filter(hdfrac, filter(hdint, signals(1:end,mic)));
        for i = 1:length(mic1)
            signal_sum(i) = signal_sum(i) + mic_delayed(i);
        end
    end
    for i = 1:length(mic1)%adds last mic - no delay
        signal_sum(i) = signal_sum(i) + signals(i,num_mics);
    end
    index = (degree/deg_res+1);
    power_lvls(index) = bandpower(signal_sum,samp_rate,[200,20000]);
    if (floor(degree/30) == degree/30) && (degree ~= 0)
        disp(degree)
    end
end

%90-180 degrees; iterates from [180,90)
signals = [mic10 mic9 mic8 mic7 mic6 mic5 mic4 mic3 mic2 mic1];%%%%%
for degree = 0:deg_res:(floor(90/deg_res)*deg_res-1)%-1 so no 90deg twice
    signal_sum = zeros(1,length(mic1));
    for mic = 1:num_mics-1 %assumes sound hits signals(1) first
        delay = calcDelay(degree,micSep,samp_rate,speed)*(num_mics - mic);
        hdint = dfilt.delay(floor(delay));%integer delay filter
        dfrac = fdesign.fracdelay(delay-floor(delay));%fractional delay
        hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
        mic_delayed = filter(hdfrac, filter(hdint, signals(1:end,mic)));
        for i = 1:length(mic1)
            signal_sum(i) = signal_sum(i) + mic_delayed(i);
        end
    end
    for i = 1:length(mic1)
        signal_sum(i) = signal_sum(i) + signals(i,num_mics);
    end
    index = (180-degree)/deg_res+1;
    power_lvls(index) = bandpower(signal_sum,samp_rate,[200,20000]);
    if (floor(degree/30) == degree/30) && (degree ~= 0)
        disp(degree)
    end
end
[pks,locs] = findpeaks(power_lvls);
disp(locs)
clear degree mic_sum delay hdint dfrac hdfrac mic_delayed signals mic9
clear i mic mic1 mic2 mic3 mic4 mic5 index tout signal_sum mic6 mic7 mic8
clear mic10 pks samp_rate speed micSep num_mics deg_res