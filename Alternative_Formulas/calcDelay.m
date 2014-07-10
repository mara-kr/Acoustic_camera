function [numSamples] = calcDelay(degrees,micSeparate,sampRate,soundSpeed) 
%Gives the number of samples that each mic should be delayed by
rads = degtorad(degrees);
sampTime = 1/sampRate;
timeDelay = micSeparate*cos(rads)/soundSpeed;
numSamples = timeDelay/sampTime;
end
