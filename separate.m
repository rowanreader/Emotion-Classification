% separates the data into testing and training data
% for each of the subjects, open files with windows
% shuffles windows, randomly select 'test' percent of windows, remove and store
% do for all files, shuffle final test and train, then save
function separate
% set the percent of data to be saved for test and the percent for train
testPercent = 0.2;
trainPercent = 0.8;
% number of windows (14 dimensional) in each game file (there are 4)
% just hard code
num = 38124;
% the actual number of windows sectioned into the test and train arrays
% only actually need one but have both just in case
testNum = floor(testPercent * num);
trainNum = num - testNum;
for i = 1:28
    if i < 10
        temp = "ProcessedData/S0" + i;
    else
        temp = "ProcessedData/S" + i;
    end 
    % file to save data to
    saveFile = "TestTrain/" + temp + ".mat";
    % train and test cells require 4xnumber, still organized by electrode
    trainData = cell(14, trainNum * 4);
    testData = cell(14, testNum * 4);
    % corresponding labels
    trainAns = zeros(1, trainNum * 4);
    testAns = zeros(1, testNum * 4);
    for j = 1:4
        file = temp + j + ".mat";
        load(file);
        % shuffle by generating randomperm
        p = randperm(num);
        newWindows = windows(:, p);
        % assign to train and test
        trainData(:,(j-1)*trainNum + 1: j*trainNum) = newWindows(:, 1:trainNum);
        testData(:, (j-1)*testNum + 1:j*testNum) = newWindows(:, trainNum + 1:end);
        % also fill in answers
        trainAns((j-1)*trainNum + 1: j*trainNum) = j;
        testAns((j-1)*testNum + 1:j*testNum) = j;
    end
    % shuffle so that all the windows are mixed in with other genres
    p = randperm(4*trainNum);
    trainData = trainData(:, p);
    trainAns = trainAns(:, p);
    p = randperm(4*testNum);
    testData = testData(:, p);
    testAns = testAns(:,p);
    save(saveFile,'trainData', 'trainAns', 'testData', 'testAns');
    disp(i);
end