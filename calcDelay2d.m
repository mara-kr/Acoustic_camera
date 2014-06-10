function [numSamples] = calcDelay2d(phi,theta,mics,mic1,mic2,sampRate,speed,micSep)
phi_rads = degtorad(phi-90);%to give correct sine values?
theta_rads = degtorad(theta);
sampTime = 1/sampRate;
[row1,col1] = find(mics == mic1);
[row2,col2] = find(mics == mic2);
if phi~=0
    if (row1==row2) && (col1~=col2)
        [dist,angle] = findDist(row1,col1,row2,col2,micSep);
        v = speed*sin(phi_rads)*sin(theta_rads+angle);
        time = dist/v;
        numSamples = abs(time/sampTime);
    elseif (row1~=row2) && (col1~=col2)
        [dist,angle] = findDist(row1,col1,row2,col2,micSep);
        v = speed*sin(phi_rads)*sin(theta_rads+angle);
        time = dist/v;
        numSamples = abs(time/sampTime);
    elseif (row1~=row2) && (col1==col2)
        [dist,angle] = findDist(row1,col1,row2,col2,micSep); %#ok<NASGU>
        v = speed*sin(phi_rads)*cos(theta_rads);
        time = dist/v;
        numSamples = abs(time/sampTime);
    else
        disp('PROBLEM!!!')
    end
else
    numSamples = 0;
end
