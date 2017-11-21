function [ grad ] = grad_calc( R1, R2, R3 )
%GRAD_CALC Calculates a gradient based on robot data
%   Using equations straight from the Thomas tmech paper

R12 = R2 - R1;
R13 = R3 - R1;

N = cross(-R12, R13);

grad = [N(1); N(2); 0];

end

