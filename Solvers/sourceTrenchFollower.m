function [Vcmd] = sourceTrenchFollower(clusterPosition, fieldGenerator)

    clusterX = clusterPosition(1);
    clusterY = clusterPosition(2);
    clusterTheta = clusterPosition(3);
    clusterD = clusterPosition(4);
    time = clusterPosition(5);
    
    % Field shifting %%
    field_shift_rate = [0 0 0 0];
    field_shift = field_shift_rate*time;
    
    %From cluster to global.
    Rgc = [cos(clusterTheta), -sin(clusterTheta);
           sin(clusterTheta), cos(clusterTheta)];
    %Cluster formation
%        2
%     <- 1
%        3
    %Robot positions in global frame
    r1_pos = [clusterX; clusterY];
    r2_pos = Rgc*[0; -clusterD] + [clusterX; clusterY];
    r3_pos = Rgc*[0; clusterD] + [clusterX; clusterY];
    
    sensorResponses = [feval(fieldGenerator, r1_pos(1), r1_pos(2)); feval(fieldGenerator, r2_pos(1), r2_pos(2)); feval(fieldGenerator, r3_pos(1), r3_pos(2))];
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];
    
    %% this is in the cluster frame, this vector aims to find the direction
    % the cluster should move so that robot 1 is on top of a trench
    centeringContributionCluster = zeros(3,1);
    %TODO this may have special cases for robot positions relative to the trench
    centeringContributionCluster = [0; vectorMagnitudes(2)-vectorMagnitudes(3); 0];
    if abs(centeringContributionCluster(2)) > 1 
        centeringContributionCluster = centeringContributionCluster/norm(centeringContributionCluster);
    end
    RclustToGlob = [cos(clusterTheta), -sin(clusterTheta), 0;
                    sin(clusterTheta), cos(clusterTheta), 0;
                    0,0,1];
    centeringContribution = RclustToGlob*centeringContributionCluster*.2;
    centeringContribution = zeros(3,1);
   
    %% this is for the gradient
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    %Gradient calc for gradient descent
    grad = grad_calc(R1, R2, R3);
    g1 = grad+centeringContribution;
    g1_unit = g1/norm(g1);
    
    
    %Rotation matrix from global frame to cluster frame.
    Rcg = [cos(clusterTheta), sin(clusterTheta), 0; 
           -sin(clusterTheta), cos(clusterTheta), 0;
           0, 0, 1];

    %% determine desiredThetac as this controller works on a non holonomic cluster 
    % cluster so that it is perpendicular to the trench   
    totalRes = -1*(sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:));
    des_theta = atan2(totalRes(2), totalRes(1));
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
        g1(1); %19
        g1(2); %20
        field_shift(1); %21
        field_shift(2); %22
        field_shift(3); %23
        field_shift(4)];%24
    Vcmd = Vcmd';
end