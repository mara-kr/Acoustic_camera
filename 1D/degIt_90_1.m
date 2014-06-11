sim mic_input 
num_mics = 4;
deg_res = 1; %Change to change resolution
averages = zeros(1,floor(90/deg_res)+1); 
micSep = .148;
%for degree = 0:deg_res:(floor(90/deg_res)*deg_res)
for degree = 50:1:60
    x = calcDelay(degree, micSep, 44100, 345); 
    x1 = x*(num_mics - 1); 
    x2 = x*(num_mics - 2); 
    x3 = x*(num_mics - 3);
    ints = [floor(x1) floor(x2) floor(x3)];
    fracs = [x1-ints(1) x2-ints(2) x3-ints(3)];
    dfrac = fdesign.fracdelay(fracs(1));
    hdfrac1 = design(dfrac, 'lagrange', 'filterstructure', 'farrowfd');
    dfrac = fdesign.fracdelay(fracs(2));
    hdfrac2 = design(dfrac, 'lagrange', 'filterstructure', 'farrowfd');
    dfrac = fdesign.fracdelay(fracs(3));
    hdfrac3 = design(dfrac, 'lagrange', 'filterstructure', 'farrowfd');
    hdint1 = dfilt.delay(ints(1));
    hdint2 = dfilt.delay(ints(2));
    hdint3 = dfilt.delay(ints(3));
    mic1_delay_int = filter(hdint1,mic1);
    mic1_delay_net = filter(hdfrac1, mic1_delay_int);
    mic2_delay_int = filter(hdint2, mic2);
    mic2_delay_net = filter(hdfrac2, mic2_delay_int);
    mic3_delay_int = filter(hdint3, mic3);
    mic3_delay_net = filter(hdfrac3, mic3_delay_int);
    mic_sum = zeros(1,length(mic4));
    for i = 1:length(mic4) %summing signals
        mic_sum(i) = mic1_delay_net(i)+mic2_delay_net(i)+mic3_delay_net(i);
        mic_sum(i) = mic_sum(i) + mic4(i);
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
    averages((degree/deg_res)+1) = average;
    degree
end
clear dfrac hdint1 hdint2 hdint3 mic1_delay_int mic2_delay_int
clear mic3_delay_int x1 x2 x3 x ints fracs hdfrac1 hdfrac2 hdfrac3
