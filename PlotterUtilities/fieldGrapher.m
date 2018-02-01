function fieldGrapher(minX, maxX, minY, maxY, fieldGenerator, displayNormalized, resolution)
    x = xField(minX, maxX, minY, maxY);
    y = yField(minX, maxX, minY, maxY);
    u = zeros(maxY-minY, maxX-minX);
    v = zeros(maxY-minY, maxX-minX);
    for i = 1:resolution:maxY-minY
        for j = 1:resolution:maxX-minX
            dirt = feval(fieldGenerator, x(i, j), y(i, j), displayNormalized);
            u(i, j) = dirt(1);
            v(i, j) = dirt(2);
        end
    end
    quiver(x, y, u, v);
end

function retval = xField(minX, maxX, minY, maxY)
    retval = zeros(maxY-minY,maxX-minX);
    row = zeros(1, maxX-minX);
    index = 1;
    for i = minX:maxX-1
        row(index) = i;
        index = index+1;
    end
    for i = 1:maxY-minY
        retval(i,:) = row;
    end
end

function retval = yField(minX, maxX, minY, maxY)
    retval = zeros(maxY-minY, maxX-minX);
    column = zeros(maxY-minY, 1);
    index = 1;
    for i = minY:maxY-1
        column(index) = i;
        index = index+1;
    end
    for i = 1:maxX-minX
        retval(:,i) = column;
    end
end