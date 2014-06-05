clear
close all


sim mic_input
mic1 = mic1 - mic1(length(mic1));
        mic1 = 0.95*mic1/max(abs(mic1));
mic2 = mic2 - mic2(length(mic2));
        mic2 = 0.95*mic2/max(abs(mic2));
mic3 = mic3 - mic3(length(mic3));
        mic3 = 0.95*mic3/max(abs(mic3));
mic4 = mic4 - mic4(length(mic4));
        mic4 = 0.95*mic4/max(abs(mic4));
sound(mic1, 44100)
sound(mic2, 44100)
sound(mic3, 44100)
sound(mic4, 44100)
