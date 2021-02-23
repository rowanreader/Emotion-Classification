function chop(file, saveFile)
% loads all 14 electrods, each is a 38252x1 array
load(file);
% AF3, AF4, F3, F4, F7, F8, FC5, FC6, O1, O2, P7, P8, T7, T8
electrodes = {AF3, AF4, F3, F4, F7, F8, FC5, FC6, O1, O2, P7, P8, T7, T8};

% each window should be 14x128 -> electrodes x pts/sec
% there should be a total of 300 windows, however 148 pts are missing
% will be a total of 298 windows
step = 128; % how many points are in each window
[num,~] = size(AF3);
numWindows = num - step;
windows = cell(14, numWindows);
for i = 1:14
    % this is the electrode we're currently working with
    temp = electrodes{i};
    % hopefully all files have enough for 298 windows. If not, can change
    % it so its variable, but that'll be a pain
    count = 0;
    for j = 1:numWindows
        count = count + 1;
        % indexing includes end point so subtract 1
        windows{i,j} = temp(count:count + step - 1);
    end
end
% have all chopped windows, save to mat file
save(saveFile, 'windows');