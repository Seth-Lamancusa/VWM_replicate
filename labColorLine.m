function [labColors] = labColorLine(res, CIECenter, colorSpaceRadius)
    labColors = zeros(3, res);
    for i = 1:length(labColors)
        labColors(:, i) = CIECenter + ...
            [0 cosd(360/res*i)*colorSpaceRadius sind(360/res*i)*colorSpaceRadius];
    end
end