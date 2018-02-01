function [ ] = plot_path( file, resolution, width, fieldGenerator)
%PLOT_PATH Plots cluster path on contour
%   Superimposes the path the robots took onto a 2D contour map.
%   'width' indicates the range to be plotted, 'resolution' is the time
%   interval in between path points.

load(file);

xmin = -width;
xmax = width;
ymin = -width;
ymax = width;

res = 1;
plotRes = 1;

x = xmin-res:res:xmax+res;
y = ymin-res:res:ymax+res;

[X,Y] = meshgrid(x,y);
field_shift = [0 0 0 0];
fieldGrapher(xmin-res, xmax+res, ymin-res, ymax+res, fieldGenerator, true, plotRes);

time = [0:resolution:data.Time(end)];
v = [-100:5:100];

%figure;
%contour(x,y,Z, v);
hold on

%plot(interp1(data.Time, data.Data(:,10), time),interp1(data.Time, data.Data(:,9), time),'kx')
plot(interp1(data.Time, data.Data(:,13), time),interp1(data.Time, data.Data(:,14), time),'ro')
plot(interp1(data.Time, data.Data(:,15), time),interp1(data.Time, data.Data(:,16), time),'go')
plot(interp1(data.Time, data.Data(:,17), time),interp1(data.Time, data.Data(:,18), time),'bo')

xlabel('X (Meters)');
ylabel('Y (Meters)');
axis square
%hold off


end

