sim mic_input_2d
mic_array = [4 3; 2 1];
signals = [mic4,mic2,mic3,mic1];
num_mics = 4;
micSep = .1;
deg_res = 5; %Change to change resolution, MUST use factors of 90,180
sampR = 44100; %sampling rate
v = 345; %speed of sound
power_lvls = zeros(floor(180/deg_res)-1, floor(180/deg_res)-1);
assert(90/deg_res == floor(90/deg_res))

for phi = -90+deg_res:deg_res:90-deg_res%excludes phi=-90
    if phi/10==floor(phi/10)
        disp(phi)
    end
    if phi~=0
        for th = deg_res:deg_res:180-deg_res%th == theta
            signalSum = zeros(1,length(mic1));
            if th<90 && phi<0 
                mics = mic_array;%mics is the mics of interest
                last = mics(end,1);
            elseif th>90 && phi<0 
                mics = mic_array;
                last = mics(1,1);
            elseif th==90 && phi<0
                mics = mic_array(1,:);
                last = mics(1);
            elseif th<90 && phi>0
                mics = mic_array;
                last = mics(1,end);
            elseif th>90 && phi>0
                mics = mic_array;
                last = mics(end,end);
            elseif th==90 && phi>0
                mics = mic_array(1,:);
                last = mics(end);    
            end
            for j = 1:numel(mics)%number of mics of interest
                mic = mics(j);
                if mic~=last
                    delay=calcDelay2d(phi,th,mics,mic,last,sampR,v,micSep);
                    micDelayed=fracFilter(signals(1:end,mic),delay);
                else
                    micDelayed=signals(1:end,mic);
                end
                for i = 1:length(mic1)
                    signalSum(i) = signalSum(i) + micDelayed(i);
                end
            end
            pind = (phi+90)/deg_res;%phi adjust to index into array
            tind = th/deg_res; %theta adjust to index into array
            power_lvls(pind,tind)=bandpower(signalSum,sampR,[200,20000]);
        end
    else
        signalSum = zeros(1,length(mic1));
        for mic=1:num_mics
            for i=1:length(mic1)
                signalSum(i) = signalSum(i)+signals(i,mic);
            end
        end
        power_lvls(90/deg_res,1) = bandpower(signalSum,sampR,[200,20000]);
    end
end
clear dfrac hdfrac hdint delay i last mic micDelayed mics phi th signals
clear signalSum tout v sampR micSep mic1 mic2 mic3 mic4 pind tind j