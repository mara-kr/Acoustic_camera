sim mic_input_2source
signals = [mic1 mic2 mic3 mic4 mic5];   
num_mics = 5;
micSep = .2; %Separation between microphones
deg_res = 5; %Change to change resolution, MUST use factors of 90,180
power_lvls = zeros(1,floor(180/deg_res)+1);

%Iterates from [0,90]
for degree = 0:deg_res:(floor(90/deg_res)*deg_res)
    signal_sum = zeros(1,length(mic1));
    for mic = 1:num_mics-1 %assumes sound hits signals(1) first
        delay = calcDelay(degree, micSep, 44100, 345)*(num_mics - mic);
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
    power_lvls(degree/deg_res+1) = bandpower(signal_sum,44100,[200,20000]);
    disp(degree)
end

%90-180 degrees; iterates from [180,90)
signals = [mic5 mic4 mic3 mic2 mic1];
for degree = 0:deg_res:(floor(90/deg_res)*deg_res-1)%-1 so no 90deg twice
    signal_sum = zeros(1,length(mic1));
    for mic = 1:num_mics-1 %assumes sound hits signals(1) first
        delay = calcDelay(degree, micSep, 44100, 345)*(num_mics - mic);
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
    power_lvls(index) = bandpower(signal_sum,44100,[200,20000]);
    disp(180-degree)
end
clear degree mic_sum delay hdint dfrac hdfrac mic_delayed 
clear i mic mic1 mic2 mic3 mic4 mic5 tout signal_sum
