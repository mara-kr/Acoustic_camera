sim mic_input 
num_mics = 4;
micSep = .1;
degree = 40;
delay = calcDelay(degree, micSep, 44100, 345);
delay1 = delay*(num_mics - 1);
delay2 = delay*(num_mics - 2);
delay3 = delay*(num_mics - 3);
ints = [floor(delay1) floor(delay2) floor(delay3)];
fracs = [delay1-ints(1) delay2-ints(2) delay3-ints(3)];
for mic = 1:(num_mics - 1)
    dfrac = fdesign.fracdelay(fracs(mic));
    hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
    hdint = dfilt.delay(ints(mic));
    if mic == 1
        mic1_delay = filter(hdfrac, filter(hdint, mic1));
    elseif mic == 2
        mic2_delay = filter(hdfrac, filter(hdint, mic2));
    elseif mic == 3
        mic3_delay = filter(hdfrac, filter(hdint, mic3));
    end
end
mic_sum = zeros(1,length(mic4));
for i = 1:length(mic4) %summing signals
    mic_sum(i) = mic1_delay(i)+mic2_delay(i)+mic3_delay(i)+mic4(i);
end
total = 0;
counter = 0;
for i=1:length(mic_sum) %finds average intensity of summed signal
    if mic_sum(i) ~= 0
        total = total + abs(mic_sum(i));
        counter = counter + 1;
    end
end
average = total/counter;
disp(average)
clear delay1 delay2 delay3 ints fracs dfrac hdfrac hdint average counter
clear total micSep mic_sum degree i mic mic1_delay mic2_delay mic3_delay
clear tout