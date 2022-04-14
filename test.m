fclose all;close all;clear;clc;

x = -pi:0.01:pi;


% plot(x,sin(x),'LineWidth',2);  hold on; str_legend{1}='sin(x)';
% plot(x,sin(3*x)+sin(5*x),'LineWidth',2);  hold on; str_legend{2}='sin(3*x)+sin(5*x)';

% plot(x,zeros(1,length(x)),'LineWidth',2,'color','black');legend(str_legend);grid on;


y = zeros(1,length(x));
for i=1:1:10
    y = y + sin(i*x).*cos((i+1)*x);
    plot(x,y,'LineWidth',2);  hold on;
end
grid on;



