function [speed] = speedOfSound(temp, units)
%speedOfSound has units as string, ie m/s
assert(isnumeric(temp))
degC = (temp-32)/1.8;
speed = 20.0457*(degC+273.15).^.5;
if strcmp (units, 'm/s')
    speed = speed;
elseif strcmp(units, 'in/s') %Manipulation with 100 to round to 2 places
    speed = speed*39.37*100;
    speed = round(speed);
    speed = speed/100;
elseif strcmp(units,'f/s')
    speed = speed*3.28084*100;
    speed = round(speed);
    speed = speed/100;
elseif strcmp(units, 'cm/s')
    speed = round(speed*100);
elseif strcmp(units, 'mph')
    speed = round(speed*2.23694*100);
    speed = speed/100;
elseif strcmp(units, 'kph')
    speed = round(speed*3.6*100);
    speed = speed/100;
else
    error('Incorrect units!');
end

function h = lagrange(N, delay)
%LAGRANGE  h=lagrange(N,delay) returns order N FIR 
%          filter h which implements given delay 
%          (in samples).  For best results, 
%          delay should be near N/2 +/- 1.
n = 0:N;
h = ones(1,N+1);
for k = 0:N
    index = find(n ~= k);
    h(index) = h(index) *  (delay-k)./ (n(index)-k);
end
