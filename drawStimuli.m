function drawStimuli(window, colors, angles, width, len, center, distFromCenter)
    % This function draws two lines at given angles and lengths. 
    % The lines are vertically centered and located a specified 
    % distance from the horizontal center of the screen.
    
    allCoords = zeros(2, 4);
    for i = 1:2
        if i==1
            startX = - distFromCenter + cosd(angles(i))*(len/2);
            startY = -sind(angles(i))*(len/2);
            endX = - distFromCenter - cosd(angles(i))*(len/2);
            endY = sind(angles(i))*(len/2);
        else
            startX = distFromCenter + cosd(angles(i))*(len/2);
            startY = -sind(angles(i))*(len/2);
            endX = distFromCenter - cosd(angles(i))*(len/2);
            endY = sind(angles(i))*(len/2);
        end
        
        allCoords(:, 2*i-1:2*i) = [startX endX; startY endY];
    end
    
    Screen('DrawLines', window, allCoords, width, ...
        [colors(:, 1) colors(:, 1) colors(:, 2) colors(:, 2)], center, 2);
end

