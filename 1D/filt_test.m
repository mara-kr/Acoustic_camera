delay = calcDelay(30,.1,44100,345);
hdint = dfilt.delay(floor(delay));%integer delay filter
dfrac = fdesign.fracdelay(delay-floor(delay));%fractional delay
hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
mic_delayed = filter(hdfrac, filter(hdint, mic1));