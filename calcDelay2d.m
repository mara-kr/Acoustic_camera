function [numSamples] = calcDelay2d(p,t,mics,mic1,mic2,sampR,speed,micSep)
%p-phi, t-theta, sampR-sampling rate
phi_rads = degtorad(p);
theta_rads = degtorad(t);
sampTime = 1/sampR;
[row1,col1] = find(mics == mic1);
[row2,col2] = find(mics == mic2);
if p~=0
    if (row1==row2) && (col1~=col2)
        dist = findDist(row1,col1,row2,col2,micSep);
        distance = dist*sin(theta_rads)*sin(phi_rads);
        time = distance/speed;
        numSamples = abs(time/sampTime);
    elseif (row1~=row2) && (col1~=col2)
        dist = findDist(row1,col1,row2,col2,micSep);
        distance = dist*sin(phi_rads)*(theta_rads);
        time = distance/speed;
        numSamples = abs(time/sampTime);
    elseif (row1~=row2) && (col1==col2)
        dist = findDist(row1,col1,row2,col2,micSep);
        distance = dist*sin(phi_rads)*cos(theta_rads);
        time = distance/speed;
        numSamples = abs(time/sampTime);
    else
        disp('PROBLEM!!!')
    end
else
    numSamples = 0;
end