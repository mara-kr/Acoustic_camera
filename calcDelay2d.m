function [numSamples] = calcDelay2d(p,t,mics,mic1,mic2,sampR,v,micSep)
%p-phi, t-theta, sampR-sampling rate
phi_rads = degtorad(p);
theta_rads = degtorad(t);
sampTime = 1/sampR;
[row1,col1] = find(mics == mic1);
[row2,col2] = find(mics == mic2);
if p~=0
    dist = findDist(row1,col1,row2,col2,micSep);
    if (row1==row2) && (col1~=col2)
        netDist = dist*sin(theta_rads)*sin(phi_rads);
    elseif (row1~=row2) && (col1~=col2)
        netDist = dist*sin(phi_rads)*sin(theta_rads);
    else %sameCol
        netDist = dist*sin(phi_rads)*cos(theta_rads);
    end
    time = netDist/v;
    numSamples = abs(time/sampTime);
else
    numSamples = 0;
end