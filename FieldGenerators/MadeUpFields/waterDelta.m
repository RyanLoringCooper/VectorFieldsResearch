function resp = waterDelta(x, y)
    regularFlow = 500;
    riverWidth = 3;
    if y >= 0
        if abs(x) < riverWidth-1;
            resp = [0, regularFlow-2];
        elseif abs(x) < y+(riverWidth+1)
            resp = outflowVec(x, y);
            %resp = [0, 0];
        else
            resp = [0, 0];
        end
    elseif x < -riverWidth || x > riverWidth
        resp = [0, 0];
    elseif y < 0
        resp = [0, regularFlow];    
    else
        resp = [0, 0];
    end
end

function retval = outflowVec(x, y)
    regularFlow = 500;
    riverWidth = 3;
    
    rotation = -((x/abs(x))*(abs(x)-(riverWidth-1)))*pi/15;
    if abs(rotation) > pi/4
        rotation = (rotation/abs(rotation)) * pi/4;
    end
    
    if abs(x) > riverWidth+1
        mag = (regularFlow-2)*3/(abs(x)-(riverWidth+1));
        if mag >= regularFlow-2
            mag = regularFlow-2;
        end
    else
        mag = regularFlow-2; 
    end
    mag = (mag*6)/y;
    if mag >= regularFlow-2
            mag = (regularFlow-2)*.9;
    end
    retval = rotate2DVector([0, mag], rotation);
end