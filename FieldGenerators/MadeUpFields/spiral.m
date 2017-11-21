function resp = spiral(x, y)
    r = (x^2+y^2)^.5;
    if r < 10
        resp = rotate2DVector([x, y], 3*pi/4);
    elseif y < -9
        resp = [0, 0];
    elseif x < 0 && x > -10 && y < -4
        resp = rotate2DVector([x, y], 3*pi/5);
    elseif x < 0
        resp = [0, -5];
    else
        resp = [0, 0];
    end
end