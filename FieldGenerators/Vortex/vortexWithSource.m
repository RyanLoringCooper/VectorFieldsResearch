function resp = vortexWithSource(x, y, varargin)
    [u, v, un, vn, V] = PotentialFlow2DSim([2, 0, 0, 100, 0; 4, 0, 0, 100, 0], x, y);
    %resp = [un, vn];
    resp = [u, v];
end