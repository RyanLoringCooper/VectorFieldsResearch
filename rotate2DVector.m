% rotation is in radians
function retval = rotate2DVector(vect, rotation)
    retval = [vect(1)*cos(rotation)-vect(2)*sin(rotation), vect(1)*sin(rotation)+vect(2)*cos(rotation)];
end