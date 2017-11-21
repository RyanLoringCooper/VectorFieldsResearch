function resp = doublet(x, y, varargin)
    [u, v, un, vn, V] = PotentialFlow2DSim([3, 0, 0, 100, 0], x, y);
    resp = [un, vn];
    %resp = [u, v];
end