sim mic_input 
num_mics = 5;
deg_res = 5; %Change to change resolution
averages = zeros(1,floor(90/deg_res)+1);
micSep = .2;
for degree = 0:deg_res:(floor(90/deg_res)*deg_res)
    delay = calcDelay(degree, micSep, 44100, 345); 
    delay1 = delay*(num_mics - 1); 
    delay2 = delay*(num_mics - 2); 
    delay3 = delay*(num_mics - 3);
    delay4 = delay*(num_mics - 4);
    ints = [floor(delay1) floor(delay2) floor(delay3) floor(delay4)];
    fracs = [delay1-ints(1) delay2-ints(2) delay3-ints(3) delay4-ints(4)];
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
        elseif mic == 4
        
            mic4_delay = filter(hdfrac, filter(hdint, mic4));
        end
    end
    mic_sum = zeros(1,length(mic5));
    for i = 1:length(mic5) %summing signals
        mic_sum(i) = mic1_delay(i)+mic2_delay(i)+mic3_delay(i);
        mic_sum(i) = mic_sum(i) + mic4_delay(i) + mic5(i);
    end
    averages((degree/deg_res)+1) = bandpower(mic_sum,44100,[200,20000]);
    disp(degree)
end
clear delay1 delay2 delay3 ints fracs dfrac hdfrac hdint average counter
clear total micSep mic_sum degree i mic mic1_delay mic2_delay mic3_delay
clear tout
