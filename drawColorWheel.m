function drawColorWheel(window, windowRect, colorWheelRot, CIECenter, colorSpaceRadius)
    % Draws a CIELAB-based color wheel in the specified Psychtoolbox window.
    % Based on Zhang and Luck 2008.
    
    [xCenter, yCenter] = RectCenter(windowRect);

    outerRadius = 400;
    innerRadius = 350;
    angles = linspace(0, 360, 360);
    labColors = labColorLine(length(angles), CIECenter, colorSpaceRadius);

    % Create the Color Wheel
    for i = 1:length(angles)
        rgbColor = lab2rgb(labColors(:, i)');
        rgbColor = min(max(rgbColor, 0), 255);  % Ensure values are in [0, 255]
        
        % Compute points for the segment of the ring
        startAngle = angles(i) - 0.5 + colorWheelRot;
        endAngle = angles(i) + 0.5 + colorWheelRot;
        [x1, y1] = pol2cart(deg2rad(startAngle), innerRadius);
        [x2, y2] = pol2cart(deg2rad(startAngle), outerRadius);
        [x3, y3] = pol2cart(deg2rad(endAngle), outerRadius);
        [x4, y4] = pol2cart(deg2rad(endAngle), innerRadius);
        
        % Define the polygon for this segment
        px = [xCenter+x1, xCenter+x2, xCenter+x3, xCenter+x4];
        py = [yCenter-y1, yCenter-y2, yCenter-y3, yCenter-y4];
        
        % Draw the segment
        Screen('FillPoly', window, rgbColor, [px' py']);
    end
end