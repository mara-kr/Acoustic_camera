sim mic_input_2source
signals = [mic1 mic2 mic3 mic4 mic5];   
num_mics = 5;
micSep = .2; %Separation between microphones
degree = 60;
signal_sum = zeros(1,length(mic5));
for mic = 1:num_mics-1 %assumes sound hits mic1 first
    delay = calcDelay(degree, micSep, 44100, 345)*(num_mics - mic);
    hdint = dfilt.delay(floor(delay));%integer delay filter
    dfrac = fdesign.fracdelay(delay-floor(delay));%fractional delay
    hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
    mic_delayed = filter(hdfrac, filter(hdint, signals(1:end,mic)));
    for i = 1:length(mic5)
        signal_sum(i) = signal_sum(i) + mic_delayed(i);
    end
end
for i = 1:length(mic5)
    signal_sum(i) = signal_sum(i) + mic5(i);
end
power_lvl = bandpower(signal_sum,44100,[200,20000]);
disp(degree)
clear degree mic_sum delay hdint dfrac hdfrac mic_delayed 
clear i mic mic1 mic2 mic3 mic4 mic5 tout signal_sum