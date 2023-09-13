function drawFixationCross(window, color, center, fixCrossWidth, lineWidth)
    % This function draws a fixation cross at the center of the screen 
    % as indicated by 'center' and with given width and line width

    xCoords = [-fixCrossWidth/2 fixCrossWidth/2 0 0];
    yCoords = [0 0 -fixCrossWidth/2 fixCrossWidth/2];
    allCoords = [xCoords; yCoords];
    
    Screen('DrawLines', window, allCoords, lineWidth, color, center, 2);
end