%% generate flat-fading channel

function [h_corr,R] = generate_channel(num_rx_ant, num_tx_ant, corr_coef)
% The channel remains static during the training phase, omit the time
% dimension

    size = [num_rx_ant, num_tx_ant];
    h = (randn(size) + 1i*randn(size));
    
    if corr_coef == 0
        h_corr = h;
        R = eye(num_rx_ant, num_rx_ant);
    else
        % Per-column spatial correlation for SIMO channels
        R = zeros([num_rx_ant, num_rx_ant]);
        for i = 1:num_rx_ant
            for j = 1:num_rx_ant
                R(i,j) = corr_coef^abs(i-j);
            end
        end
        h_corr= R^(1/2) * h;
    end
    
end