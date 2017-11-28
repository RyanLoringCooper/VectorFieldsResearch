function resp = doublet(x, y, varargin)
    [u, v, un, vn, V] = PotentialFlow2DSim([3, 0, 0, 100, 0], x, y);
    if nargin == 3 && varargin{1}
        resp = [un, vn];
    else
        resp = [u, v];
    end    
end