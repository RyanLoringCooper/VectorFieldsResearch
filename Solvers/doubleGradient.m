function [Vcmd] = doubleGradient(clusterPosition)
    clusterX = clusterPosition(1);
    clusterY = clusterPosition(2);
    clusterTheta = clusterPosition(3);
    clusterD = clusterPosition(4);
    time = clusterPosition(5);
    
    
    %% Field shifting %%
    field_shift_rate = [0 0 0 0];
    field_shift = field_shift_rate*time;
    
    %From cluster to global.
    Rgc = [cos(clusterTheta), -sin(clusterTheta);
           sin(clusterTheta), cos(clusterTheta)];
       
    %Cluster formation
%        1
%
%     2     3

    %Robot positions in global frame
    r1_pos = Rgc*[clusterD; 0] + [clusterX; clusterY];
    r2_pos = Rgc*[-0.5*clusterD; -0.8660*clusterD] + [clusterX; clusterY];
    r3_pos = Rgc*[-0.5*clusterD; 0.8660*clusterD] + [clusterX; clusterY];
    
    vectorResponse = [sinkField(r1_pos(1), r1_pos(2)); sinkField(r2_pos(1), r2_pos(2)); sinkField(r3_pos(1), r3_pos(2))];
    %vectorResponse = [waterDelta(r1_pos(1), r1_pos(2)); waterDelta(r2_pos(1), r2_pos(2)); waterDelta(r3_pos(1), r3_pos(2))];
    %vectorResponse = getVectorResponse([vortex(r1_pos(1), r1_pos(2)); vortex(r2_pos(1), r2_pos(2)); vortex(r3_pos(1), r3_pos(2))]);
    
    R1X = [r1_pos; vectorResponse(1,1)];
    R1Y = [r1_pos; vectorResponse(1,2)];
    
    R2X = [r2_pos; vectorResponse(2,1)];
    R2Y = [r2_pos; vectorResponse(2,2)];
    
    R3X = [r3_pos; vectorResponse(3,1)];
    R3Y = [r3_pos; vectorResponse(3,2)];
    
    grad = grad_calc(R1X, R2X, R3X)+grad_calc(R1Y, R2Y, R3Y);
    grad = [-grad(1), -grad(2), 0]
    gXY_unit = grad/norm(grad)

    %Rotation matrix from global frame to cluster frame.
    Rcg = [cos(clusterTheta), sin(clusterTheta), 0; 
           -sin(clusterTheta), cos(clusterTheta), 0;
           0, 0, 1];

    des_theta = atan2(gXY_unit(2), gXY_unit(1));
    thetac_dot = (des_theta - clusterTheta);

    d_dot = 0; %Can be used to change the size of the cluster
    yc_dot = 0;
    xc_dot = 1;

    %Transformation into global frame
    vg_dot = Rgc*([xc_dot yc_dot]');
    xg_dot = vg_dot(1);
    yg_dot = vg_dot(2);
    
    %The number of each output can be used to select the vale you wish to plot
    Vcmd = [
        xg_dot; %1
        yg_dot; %2
        thetac_dot; %3
        d_dot;%4
        field_shift_rate(1); %5
        field_shift_rate(2); %6
        field_shift_rate(3); %7
        field_shift_rate(4); %8
        clusterX; %9
        clusterY; %10
        clusterTheta; %11
        clusterD; %12
        r1_pos(1);  %13
        r1_pos(2); %14
        r2_pos(1); %15
        r2_pos(2); %16
        r3_pos(1); %17
        r3_pos(2); %18
        grad(1); %19
        grad(2); %20
        field_shift(1); %21
        field_shift(2); %22
        field_shift(3); %23
        field_shift(4)];%24
    Vcmd = Vcmd';
end

function retVal = getVectorResponse(vecs)
    vecs = minMaxBetweenNeg1and1(vecs);
    [rows, cols] = size(vecs);
    for i = 1:rows
        for j = 1:cols
            if vecs(i, j) ~= 0
                vecs(i, j) = (vecs(i, j)/abs(vecs(i, j))*(1-abs(vecs(i, j))));
            end
        end
    end
    retVal = vecs;
end

