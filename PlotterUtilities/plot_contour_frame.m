function [ ] = plot_contour_frame( file, resolution, width, color )
%PLOT_PATH Summary of this function goes here
%   Detailed explanation goes here

load(file);

xmin = -width;
xmax = width;
ymin = -width;
ymax = width;

res = 1;

x = xmin-res:res:xmax+res;
y = ymin-res:res:ymax+res;

[X,Y] = meshgrid(x,y);
field_shift = [0 0 0 0];
Z = scalar_surface(X,Y, field_shift);
contour(x,y,Z);

time = [0:resolution:data.Time(end)];

figure;
v = [-100:5:100];
contour(x,y,Z,v);
hold on

%plot(data.Data(:,9),data.Data(:,10),'kx')
%plot(data.Data(:,13),data.Data(:,14),'ro')
%plot(data.Data(:,15),data.Data(:,16),'go')
%plot(data.Data(:,17),data.Data(:,18),'bo')
%plot(interp1(data.Time, data.Data(:,9), time),interp1(data.Time, data.Data(:,10), time),'kx')
%plot(interp1(data.Time, data.Data(:,13), time),interp1(data.Time, data.Data(:,14), time),'ro')
%plot(interp1(data.Time, data.Data(:,15), time),interp1(data.Time, data.Data(:,16), time),'go')
%plot(interp1(data.Time, data.Data(:,17), time),interp1(data.Time, data.Data(:,18), time),'bo')

% xc = interp1(data.Time, data.Data(:,9), time) - interp1(data.Time, data.Data(:,6), time).*time;
% yc = interp1(data.Time, data.Data(:,10), time) - interp1(data.Time, data.Data(:,5), time).*time;
% plot(yc, xc, 'kx');

% plot(interp1(data.Time, data.Data(:,14), time)- interp1(data.Time, data.Data(:,5), time).*time,interp1(data.Time, data.Data(:,13),time) - interp1(data.Time, data.Data(:,6), time).*time,'Marker','o','Color',color, 'LineStyle', 'none')
% plot(interp1(data.Time, data.Data(:,16), time)- interp1(data.Time, data.Data(:,5), time).*time,interp1(data.Time, data.Data(:,15),time) - interp1(data.Time, data.Data(:,6), time).*time,'Marker','o','Color',color, 'LineStyle', 'none')
% plot(interp1(data.Time, data.Data(:,18), time)- interp1(data.Time, data.Data(:,5), time).*time,interp1(data.Time, data.Data(:,17),time) - interp1(data.Time, data.Data(:,6), time).*time,'Marker','o','Color',color, 'LineStyle', 'none')

plot(interp1(data.Time, data.Data(:,14), time(1:250))- interp1(data.Time, data.Data(:,5), time(1:250)).*time(1:250),interp1(data.Time, data.Data(:,13),time(1:250)) - interp1(data.Time, data.Data(:,6), time(1:250)).*time(1:250),'Marker','o','Color',color, 'LineStyle', 'none')
plot(interp1(data.Time, data.Data(:,16), time(1:250))- interp1(data.Time, data.Data(:,5), time(1:250)).*time(1:250),interp1(data.Time, data.Data(:,15),time(1:250)) - interp1(data.Time, data.Data(:,6), time(1:250)).*time(1:250),'Marker','o','Color',color, 'LineStyle', 'none')
plot(interp1(data.Time, data.Data(:,18), time(1:250))- interp1(data.Time, data.Data(:,5), time(1:250)).*time(1:250),interp1(data.Time, data.Data(:,17),time(1:250)) - interp1(data.Time, data.Data(:,6), time(1:250)).*time(1:250),'Marker','o','Color',color, 'LineStyle', 'none')


xlabel('Y');
ylabel('X');
axis square
hold off


end

