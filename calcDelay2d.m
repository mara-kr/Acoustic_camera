function [numSamples] = calcDelay2d(p,t,mics,mic1,mic2,sampR,speed,micSep)
%p-phi, t-theta, sampR-sampling rate
phi_rads = degtorad(p);
theta_rads = degtorad(t);
sampTime = 1/sampR;
[row1,col1] = find(mics == mic1);
[row2,col2] = find(mics == mic2);
if p~=0
    if (row1==row2) && (col1~=col2)
        [dist,angle] = findDist(row1,col1,row2,col2,micSep);
        %disp(dist),disp(angle)
        v = speed*sin(phi_rads)*sin(theta_rads+angle);
        %disp(v)
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