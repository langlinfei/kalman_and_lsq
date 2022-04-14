fclose all;close all;clear;clc;

matrix_Q = [0.10,0.00; 0.00,0.10]; P_w = [0.316;0.316]; % Estimate the covariance matrix
matrix_R = [1.00,0.00; 0.00,1.00]; P_v = [1;1];  % Measure the covariance matrix
matrix_A = [1,1; 0,1];  % State-space equations
matrix_H = [1,0; 0,1];  % State-space equations
matrix_E = [1,0; 0,1];  % Identity matrix
P = [1,0;0,1];  % Initial covariance matrix

% Measure Value
mea_data = load('data.txt');len = length(mea_data);
cal_x_ = zeros(len,2); cal_x = zeros(len,2);ret_x = zeros(len,2); x = [0;1];
% kalman fiter solove
for i=1:len
    % predict
    x_ = matrix_A*x;
    P_ = matrix_A*P*matrix_A' + matrix_Q;
    disp('-----------[predict:x_¡¢P_]--------------');
    disp(x_);disp(P_);
    % updata
    Kk = P_*matrix_H/((matrix_H*P_*matrix_H'+matrix_R));
    x = x_ + Kk*((mea_data(i,:)' + rand(1)*P_v) - matrix_H*x_);
    P = (matrix_E-Kk*matrix_H)*P_;
    disp('-----------[updata:Kk¡¢x¡¢P]--------------');
    disp(Kk);disp(x);disp(P);
    
    % Save procedure data
    cal_x_(i,:) = x_';
    cal_x(i,:) = x';
    x = x + rand(1)*P_w;
    ret_x(i,:) = x';
    fprintf('\n\n++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
end

% plot
figure(1);
subplot(2,1,1);
plot(cal_x_(:,1),'LineWidth',2);  hold on; str_legend{1}='Predict'; 
plot(cal_x(:,1),'LineWidth',2);   hold on; str_legend{2}='Posterior';
plot(mea_data(:,1),'LineWidth',2);hold on; str_legend{3}='Measure';
plot(ret_x(:,1),'LineWidth',2);   hold on; str_legend{4}='Practical';
legend(str_legend);title('Position');

subplot(2,1,2);
plot(cal_x_(:,2),'LineWidth',2);  hold on; str_legend{1}='Predict';
plot(cal_x(:,2),'LineWidth',2);   hold on; str_legend{2}='Posterior';
plot(mea_data(:,2),'LineWidth',2);hold on; str_legend{3}='Measure';
plot(ret_x(:,2),'LineWidth',2);   hold on; str_legend{4}='Practical';
legend(str_legend);title('Velocity');













