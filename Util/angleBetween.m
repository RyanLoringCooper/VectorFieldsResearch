function ang = angleBetween(endVec, startVec)
    ang = atan2(endVec(2),endVec(1))-atan2(startVec(2),startVec(1));
end