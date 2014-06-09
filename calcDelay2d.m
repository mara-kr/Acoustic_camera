function [numSamples] = calcDelay2d(phi,theta,a,dist,sampRate,speed)
%Gives the number of samples to delay for a given dist/angles mic
%a is angle from horizontal to path between mics
phi_rads = degtorad(phi);
theta_rads = degtorad(theta);
sampTime = 1/sampRate;
if a~= 90 && phi~=0
    a_rads = degtorad(a);
    timeDelay = (dist*cos(a_rads))/(speed*sin(phi_rads)*sin(theta_rads));
    numSamples = timeDelay/sampTime;
elseif a==90 && phi~=0
    timeDelay = (dist)/(speed*sin(phi_rads)*cos(theta_rads));
    numSamples = timeDelay/sampTime;
elseif phi==0
    numSamples = 0;
end
