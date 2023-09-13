function [error, rt] = runTrial(window, windowRect, bgColor, ifi, ...
    stimAngles, stimColors, cueColorIdx)
    [xCenter, yCenter] = RectCenter(windowRect);

    fixDur = .5;
    memDur = .2;
    delayDur = .5;
    cueDur = .1;
    postcueDelayDur = .6;

    fixColor = 0;
    fixCrossWidth = 30;
    fixLineWidth = 5;
    stimLineWidth = 5;
    stimLineLength = 80;
    stimDistFromCenter = 80;
    cueCircleColor = 0;
    cueCircleRad = 180;
    cueCircleWidth = 5;

    drawFixationCross(window, fixColor, [xCenter, yCenter], ...
        fixCrossWidth, fixLineWidth);
    Screen('Flip', window);
    pause(fixDur - ifi*.9);

    drawStimuli(window, stimColors, stimAngles, stimLineWidth, ...
        stimLineLength, [xCenter, yCenter], stimDistFromCenter);
    Screen('Flip', window);
    pause(memDur - ifi*.9)

    Screen('FillRect', window, bgColor);
    Screen('Flip', window);
    pause(delayDur - ifi*.9);

    drawFixationCross(window, stimColors(:, cueColorIdx), ...
        [xCenter, yCenter], fixCrossWidth, fixLineWidth);
    Screen('Flip', window);
    pause(cueDur - ifi*.9);

    drawFixationCross(window, fixColor, [xCenter, yCenter], ...
        fixCrossWidth, fixLineWidth);
    Screen('Flip', window);

    Screen('FillRect', window, bgColor);
    Screen('FrameOval', window, cueCircleColor, ...
        [xCenter - cueCircleRad, yCenter - cueCircleRad, ...
        xCenter + cueCircleRad, yCenter + cueCircleRad], cueCircleWidth);
    pause(postcueDelayDur - ifi*.9);
    startTime = cputime;
    Screen('Flip', window);
    ShowCursor('arrow');

    while (1)
        [~, ~, buttons] = GetMouse(window);
        if (buttons(1))
            break;
        end
    end
    while (1)
        [x, y, buttons] = GetMouse(window);
        if (~buttons(1))
            endTime = cputime;
            break;
        end
    end
    xRel = x - xCenter;
    yRel = y - yCenter;
    angle = -atan2d(yRel, xRel);
    rt = endTime - startTime;

    % Direct error
    error_direct = mod(angle - stimAngles(cueColorIdx) + 180, 360) - 180;

    % Error considering the opposite direction
    error_opposite = mod(angle - (stimAngles(cueColorIdx) + 180) + 180, 360) - 180;

    % Choose the error with the smallest magnitude
    if abs(error_direct) < abs(error_opposite)
        error = error_direct;
    else
        error = error_opposite;
    end
end