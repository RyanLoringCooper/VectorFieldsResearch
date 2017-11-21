function retval = minMaxBetweenNeg1and1(vecs)
    [rows, cols] = size(vecs);
    max = -100000000000;
    min = 100000000000;
    for i = 1:rows
        for j = 1:cols
            if vecs(i, j) > max
                max = vecs(i, j);
            end
            if vecs(i, j) < min
                min = vecs(i, j);
            end
        end
    end
    diff = max-min;
    retval = 2*((vecs-min)/diff)-1;
end