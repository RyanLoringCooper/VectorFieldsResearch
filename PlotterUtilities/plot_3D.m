function [ ] = plot_3D( file, resolution, width, color )
%PLOT_3D Plots 3D path
%   This function superimposes the path of the robots onto a 3D surface.
%   The data is read in from a .mat file that the sim creates.
%   'width' indicates the range that is plotted, and 'resolution' is the
%   time interval between points on the path.

load(file);

xmin = -width;
xmax = width;
ymin = -width;
ymax = width;

res = 1;

x = xmin-res:res:xmax+res;
y = ymin-res:res:ymax+res;

fieldshift = [0 0 0 0];

[X,Y] = meshgrid(x,y);
Z = scalar_surface(X,Y,fieldshift);

time = [0:resolution:data.Time(end)];

%SURFACE PLOTS%
%figure; %Use this if you want a new figure every time
hold on;
h=surf(x,y,Z); axis square; set(h,'edgecolor','none');

C_Z = scalar_surface(interp1(data.TIme, data.Data(:,10),time),interp1(data.Time, data.Data(:,9),time), fieldshift);

%plot3(data.Data(1,10),data.Data(1,9), C_Z(1), 'bo', 'markers', 20);
plot3(interp1(data.Time, data.Data(:,10), time),interp1(data.Time, data.Data(:,9), time), C_Z, 'Color', color, 'LineWidth', 4);
xlabel('Y (Meters)');
ylabel('X (Meters)');
zlabel('magnitude');
contour3(x, y, Z, 20, 'k'); % Adds contour lines to the surface
colormap('gray'); %Changes color scheme
caxis([-50, 100]); %Adjusts the color scale of the surface
%hold off %Bring this pack if you don't want to keep superimposing

xlim([-300 300])
ylim([-300 300])
view([-35 22])
grid

end


