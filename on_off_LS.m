

function [ele_MSE, var_in_theory] = on_off_LS(N, num_tx_ant, num_rx_ant, K, T, corr_coef, no_var)
% %% configurations
% % tx_power = 1;
% N = 1000; % monte-carlo
% 
% num_tx_ant = 1;
% num_rx_ant = 10;
% K = 20;
% T = K + 1;
% 
% corr_coef = 1;
% no_var = 0.01;


%% main function


    % generate pilot signals: use QPSK or QAM modulation
    x = zeros([T,num_tx_ant,1]);
    symbol_set = [1+1i, 1-1i, -1+1i, -1-1i];
    ind = randi([1,4],T,1);
    for i = 1:T
        x(i,:,1)= 1/sqrt(2) * symbol_set(ind(i,1));
    end

    temp_X = zeros([num_rx_ant, T]);
    for i = 1:T
        temp_X(:,i) = x(i,:,:)*ones([num_rx_ant,1]);
    end
    X = diag(reshape(temp_X, [num_rx_ant*T,1])); % TM * TM

    % RIS parameters
    PHI = blkdiag(1, eye(K,K));
    PHI(:,1) = 1;

    % generate observation matrix for on-off method
    H = X * (kron(PHI, eye(num_rx_ant, num_rx_ant))); 

    % compute covariance matrix
    cov_mat = no_var * inv(H'*H);
    % cov_mat_2 = no_var * kron(inv(PHI'*PHI),eye(num_rx_ant,num_rx_ant));
    var_in_theory = diag(cov_mat);

    % total_est_error = zeros([N,1]);
    error_mat = zeros([(K+1)*num_rx_ant, N]);

    for iter = 1:N

        % generate correlated Rayleigh flat-fading channel
        [theta, ~] = generate_channel(num_rx_ant*(K + 1),num_tx_ant,corr_coef); % equivalent SIMO channels

        % apply channel on the observation matrix to get the received signal s
        s = apply_channel(theta, H, no_var);

        % standard way of computation
        theta_est = inv(H'*H) * H' * s;
        % theta_est_simple = inv(H) * s;


        % compute element-wise squared error
        error_vec = theta - theta_est;
        error_mat(:,iter) = (abs(error_vec)).^2;

        % compute total squared error
        % total_est_error(iter) = sum((abs(error_vec)).^2);
        
        % compute the received SNR
        snr = abs(s).^2/no_var;
        snr_db = 10*log10(mean(snr));

    end

    ele_MSE = mean(error_mat,2);
    % compute the mean of squared error (total)
    % MSE = mean(total_est_error,'all');


end








