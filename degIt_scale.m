sim mic_input
signals = [mic1 mic2 mic3 mic4 mic5];   
num_mics = 5;
micSep = .2;
deg_res = 30; %Change to change resolution
power_lvls = zeros(1,floor(90/deg_res)+1);
for degree = 0:deg_res:(floor(90/deg_res)*deg_res)
    signal_sum = zeros(1,length(mic5));
    for mic = 1:num_mics-1 %assumes sound hits mic1 first
        delay = calcDelay(degree, micSep, 44100, 345)*(num_mics - mic);
        hdint = dfilt.delay(floor(delay));
        dfrac = fdesign.fracdelay(delay-floor(delay));
        hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
        mic_delayed = filter(hdfrac, filter(hdint, signals(1:end,mic)));
        for i = 1:length(mic5)
            signal_sum(i) = signal_sum(i) + mic_delayed(i);
        end
    end
    for i = 1:length(mic5)
        signal_sum(i) = signal_sum(i) + mic5(i);
    end
    power_lvls(degree/deg_res+1) = bandpower(signal_sum,44100,[200,20000]);
    disp(degree)
end
clear average degree mic_sum delay hdint dfrac hdfrac mic_delayed 
clear i mic mic1 mic2 mic3 mic4 mic5 tout signal_sum