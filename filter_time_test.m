sim mic_input
%hdint = dfilt.delay(2331);
dfrac = fdesign.fracdelay(.15263784);
hdfrac = design(dfrac, 'lagrange', 'filterstructure', 'farrowfd');
mic1_delayed_net = filter(hdfrac, mic1);
