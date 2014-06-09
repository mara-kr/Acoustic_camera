sim mic_input_2d
mics = [1 3; 2 4];
signals = [mic1; mic2; mic3; mic4];
num_mics = 4;
micSep = .1;
deg_res = 1; %Change to change resolution, MUST use factors of 90,180
samp_rate = 44100;
speed = 345; %speed of sound
power_lvls = zeros(floor(180/deg_res)+1, floor(180/deg_res)+1);

for phi = -90:deg_res:0
        for theta = deg_res:deg_res:180-deg_res
            if theta<90 %Cannot be 0
                last = mics(end,end);
                for mic = 1:num_mics-1
                    
                end
            elseif theta == 90
                
            elseif theta>90 %Cannot be 180
                
            end
        end 
end

for phi = deg_res:deg_res:90
        for theta = deg_res:deg_res:180-deg_res
            if theta<90 %Cannot be 0
                
            elseif theta == 90
                
            elseif theta>90 %Cannot be 180
                
            end
        end 
end