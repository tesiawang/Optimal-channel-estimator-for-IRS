%% main function and plot figures: LS

% [ele_MSE, var_in_theory] = on_off_LS (N , num_tx_ant, num_rx_ant, K, T, corr_coef, no_var)

no_var = [1e-4, 10^(-3.5), 1e-3,10^(-2.5),1e-2,10^(-1.5), 1e-1, 10^(-0.5), 1, 10^0.5];
snr_db = zeros([length(no_var),1]);

LS_obj_mse = zeros([length(no_var),1]);
dir_mse = zeros([length(no_var),1]);
cas_mse = zeros([length(no_var),1]);

for i = 1:length(no_var)
    [ele_MSE, var_in_theory] = on_off_LS(200,1,10,50,51,0.5,no_var(i));
    LS_obj_mse(i) = mean(ele_MSE);
    dir_mse(i) = mean(ele_MSE(1:10));
    cas_mse(i) = mean(ele_MSE(11:510));
    snr_db(i) = 10 * log10(1/no_var(i));
end

figure;

% semilogy(snr_db, LS_obj_mse, '>-', ...
%          'Color',[0.75 0.31 0.27],...
%          'DisplayName','MSE of all the channel parameters',...
%          'LineWidth',1.5,...
%          'MarkerSize',2);


semilogy(snr_db, dir_mse, 'o-',...
         'Color',[0.301 0.506 0.741],...
         'DisplayName',"MSE of direct channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);
hold on;

semilogy(snr_db, cas_mse, 's-',...
         'Color',[0.608 0.733 0.35],...
         'DisplayName',"MSE of cascaded channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);

grid on;
xlabel("SNR (dB)");
ylabel("Mean squared error"); % averaged over all the channel coefficients


%% main function and plot figures: DFT

%[ele_MSE, var_in_theory] = dft_matrix_LS(N, num_tx_ant, num_rx_ant, K, T, corr_coef, no_var)
% 
no_var = [1e-4, 10^(-3.5), 1e-3,10^(-2.5),1e-2,10^(-1.5), 1e-1, 10^(-0.5), 1, 10^0.5];
snr_db = zeros([length(no_var),1]);

LS_obj_mse_dft = zeros([length(no_var),1]);
dir_mse_dft = zeros([length(no_var),1]);
cas_mse_dft = zeros([length(no_var),1]);

for i = 1:length(no_var)
    [ele_MSE_dft, var_in_theory_dft] = dft_matrix_LS(200,1,10,50,51,0.5,no_var(i));
    LS_obj_mse_dft(i) = mean(ele_MSE_dft);
    dir_mse_dft(i) = mean(ele_MSE_dft(1:10));
    cas_mse_dft(i) = mean(ele_MSE_dft(11:510));
    snr_db(i) = 10 * log10(1/no_var(i));
end

figure;

% semilogy(snr_db, LS_obj_mse, '>-', ...
%          'Color',[0.75 0.31 0.27],...
%          'DisplayName','MSE of all the channel parameters',...
%          'LineWidth',1.5,...
%          'MarkerSize',2);

semilogy(snr_db, dir_mse, 'o-',...
         'Color',[0.301 0.506 0.741],...
         'DisplayName',"MSE of direct channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);
hold on;
     
semilogy(snr_db, cas_mse, 's-',...
         'Color',[0.608 0.733 0.35],...
         'DisplayName',"MSE of cascaded channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);
hold on;
semilogy(snr_db, dir_mse_dft, 'o-',...
         'Color',[0.75 0.31 0.27],...
         'DisplayName',"MSE of direct channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);
hold on;
semilogy(snr_db, cas_mse_dft, 's-',...
         'Color',[0.608 0.733 0.35],...
         'DisplayName',"MSE of cascaded channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);

grid on;
xlabel("SNR (dB)");
ylabel("Mean squared error"); % averaged over all the channel coefficients

%% Change the parameter K

K_set = [20,40,60,80,100];
no_var = 1e-2;

LS_obj_mse = zeros([length(K_set),1]);
dir_mse = zeros([length(K_set),1]);
cas_mse = zeros([length(K_set),1]);

for i = 1:length(K_set)
    T = K_set(i)+1;
    K = K_set(i);
    [ele_MSE, var_in_theory] = on_off_LS(200,1,10,K,T,0.5,no_var);
    LS_obj_mse(i) = mean(ele_MSE);
    dir_mse(i) = mean(ele_MSE(1:10));
    cas_mse(i) = mean(ele_MSE(11:10*(K_set(i)+1)));
    %snr_db(i) = 10 * log10(1/no_var(i));
end

% figure;

% semilogy(snr_db, LS_obj_mse, '>-', ...
%          'Color',[0.75 0.31 0.27],...
%          'DisplayName','MSE of all the channel parameters',...
%          'LineWidth',1.5,...
%          'MarkerSize',2);

figure;

semilogy(K_set, dir_mse, 'o-',...
         'Color',[0.301 0.506 0.741],...
         'DisplayName',"MSE of direct channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);
hold on;

semilogy(K_set, cas_mse, 's-',...
         'Color',[0.608 0.733 0.35],...
         'DisplayName',"MSE of cascaded channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);

grid on;
xlabel("The number of IRS elements K");
ylabel("Mean squared error"); % averaged over all the channel coefficients

%%

K_set = [20,40,60,80,100];
no_var = 1e-2;

LS_obj_mse_dft = zeros([length(K_set),1]);
dir_mse_dft = zeros([length(K_set),1]);
cas_mse_dft = zeros([length(K_set),1]);

for i = 1:length(K_set)
    T = K_set(i)+1;
    K = K_set(i);
    [ele_MSE_dft, var_in_theory_dft] = dft_matrix_LS(200,1,10,K,T,0.5,no_var);
    LS_obj_mse_dft(i) = mean(ele_MSE_dft);
    dir_mse_dft(i) = mean(ele_MSE_dft(1:10));
    cas_mse_dft(i) = mean(ele_MSE_dft(11:10*(K_set(i)+1)));
    %snr_db(i) = 10 * log10(1/no_var(i));
end

% figure;

% semilogy(snr_db, LS_obj_mse, '>-', ...
%          'Color',[0.75 0.31 0.27],...
%          'DisplayName','MSE of all the channel parameters',...
%          'LineWidth',1.5,...
%          'MarkerSize',2);

figure;

semilogy(K_set, dir_mse_dft, 'o-',...
         'Color',[0.301 0.506 0.741],...
         'DisplayName',"MSE of direct channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);
hold on;

semilogy(K_set, cas_mse_dft, 's-',...
         'Color',[0.608 0.733 0.35],...
         'DisplayName',"MSE of cascaded channel parameters",...
         'LineWidth',1.5,...
         'MarkerSize',6);

grid on;
xlabel("The number of IRS elements K");
ylabel("Mean squared error"); % averaged over all the channel coefficients


