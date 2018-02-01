% z score normalizes the columns of vecs
function normed = zScoreNormalized(vecs)
    vecs = vecs';
    [rows, cols] = size(vecs);
    normed = zeros(rows, cols);
    for i = 1:rows
        row = vecs(i, :);
        row_norm = (row-mean(row))/std(row);
        normed(i, :) = row_norm;
    end
    normed = normed';
end