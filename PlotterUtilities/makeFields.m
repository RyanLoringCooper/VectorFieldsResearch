function makeFields
    figure('Name', 'Eddy', 'NumberTitle', 'off');
    fieldGrapher(-15+1, 10, -10, 20, 'spiral');
    figure('Name', 'Water Delta', 'NumberTitle', 'off');
    fieldGrapher(-15+1, 15, -5, 15, 'waterDelta');
    figure('Name', 'Flowing River', 'NumberTitle', 'off');
    fieldGrapher(-10, 10-1, -5, 5, 'flowingRiver');
    figure('Name', 'Sink', 'NumberTitle', 'off');
    fieldGrapher(-5, 5+1, -5, 5+1, 'sinkField');
end