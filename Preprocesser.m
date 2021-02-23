% goes through all processed data files, chops up into 1 second windows
% 5 min of data/file, 14 electrodes, 128 Hz  
% -> 300 arrays of 14x60 per file
% saves in file ProcessedData/id_game
num = 28;
storeDir = "ProcessedData/";

for i = 1:28
    if i < 10
        temp = "S0" + i;
    else
        temp = "S" + i;
    end
    for j = 1:4
        file = "GAMEEMO/(" + temp + ")/Preprocessed EEG Data/.mat format/" + temp + "G" + j + "AllChannels.mat";
        
        % call chopping function, will open and convert to hamming windows 
        % and save to file
        saveFile = storeDir + temp + j;
        chop(file, saveFile);
    end
    disp(i);
end