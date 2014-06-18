function [micDelayed] = fracFilter(signal, delay)
%fracFilter delays signal by delay samples (which is a fraction)
hdint = dfilt.delay(floor(delay));
% dfrac = fdesign.fracdelay(delay-floor(delay));
% hdfrac = design(dfrac,'lagrange','filterstructure','farrowfd');
% micDelayed = filter(hdfrac,filter(hdint,signal));
micDelayed = filter(hdint,signal);
end