function [ y ] = PlotGlider( u )
%PlotGlider( u )
%   u = input vector [xe, ye, ze, phi, theta, psi] angles in radians
persistent first F1
y=0; %dummy output
if isempty(first)
    % Make figure window with floor and wall
    F1=figure;
    floor=fill3([0 200 200 0],[-10 -10 10 10],[0 0 0 0],'g');
    hold on
    alpha(floor,0.1);
    wall=fill3([200 200 200 200],[-50 -50 50 50],[0 200 200 0],[.6 .4 0]);
    alpha(wall,0.1);
    first=1;
    axis equal
    grid on
else
%     % Check if figure window was closed.  If it was, make new figure window
%     try
%         set(F1,'Visible','on');
%     catch
%         F1=figure;
%         floor=fill3([0 100 100 0],[-10 -10 10 10],[0 0 0 0],'g');
%         hold on
%         alpha(floor,0.1);
%         wall=fill3([100 100 100 100],[-50 -50 50 50],[0 100 100 0],[.6 .4 0]);
%         alpha(wall,0.1);
%         first=1;
%         axis equal
%         grid on
%     end
    plot3(u(1),-u(2),-u(3)-5000,'k*')
end

end

