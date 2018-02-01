% vect is a 1xn vector, will compute cartesian distance
function mag = getMagnitude(vect)
    temp = size(vect);
    length = temp(2);
    mag = 0;
    for i = 1:length
        mag = mag+vect(1, i)*vect(1, i);
    end
    mag = mag^.5;
end