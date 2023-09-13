  % Suppress sync warning
Screen('Preference','SkipSyncTests', 1);

% Setup
sca;
close all;
clear;
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);

% Config
fileName = "data.xlsx";
angles = [-180 -165 -150 -135 -120 -105 -90 -75 -60 -45 -30 -15 0 15 30 45 60 75 90 105 120 135 150 165];
CIECenter = [70 20 38];
colorSpaceRadius = 60;
numColors = 18;

% Define colors
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
bg = white / 2;
labColors = labColorLine(numColors, CIECenter, colorSpaceRadius);
rgbColors = labColors;
for i = 1:numColors
    rgbColors(:, i) = lab2rgb(labColors(:, i)', 'OutputType', 'double');
end

% Prompt for subject number
prompt = {'Enter subject number:'};
dlgtitle = 'Subject Number';
dims = [1 35];
subNum = inputdlg(prompt, dlgtitle, dims);

% Open an on screen window, color it grey, find ifi
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, bg);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[xCenter, yCenter] = RectCenter(windowRect);
ifi = Screen('GetFlipInterval', window);

% Run 5 trials and write to data file
for i = 1:5
    % Set trial parameters
    randomIndices = randperm(length(angles), 2);
    trialAngles = angles(randomIndices);
    randomIndices = randperm(length(rgbColors), 2);
    trialColors = rgbColors(:, randomIndices);
    cueIdx = randi(2);

    % Run trial, collect data, and write to spreadsheet
    [err, rt] = runTrial(window, windowRect, bg, ifi, trialAngles, ...
        trialColors, cueIdx);
    trialData = [subNum, ...
        trialColors(1,1), trialColors(2,1), trialColors(3,1), ...
        trialColors(1,2), trialColors(2,2), trialColors(3,2), ...
        cueIdx, trialAngles(1), trialAngles(2), err, rt];
    writecell(trialData,fileName,'WriteMode','append');
end

% Clear the screen.
sca;