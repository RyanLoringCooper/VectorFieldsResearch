function resp = vortex(x, y, varargin)
    [u, v, un, vn, V] = PotentialFlow2DSim([4, 0, 0, 100, 0], x, y);
    %resp = [un, vn];
    resp = [u, v];
end