%% Apply flat-fading channel and add AWGN noise

function s = apply_channel(h_corr, observ_mat, no_var)
    % input
    % observ_mat: [T*num_rx_ant,(K+1)*num_rx_ant]
    % h_corr: [(K + 1)*num_rx_ant, num_tx_ant]
    % s : [T*num_rx_ant, 1]
    
    row_dim = size(observ_mat,1);
    
    s = zeros([row_dim, 1]);
    
    % Stack all the T samples together to compute
    % complex gaussian distribution CN(0,1): real N(0,1/2) and imaginary N(0,1/2)
    noise = sqrt(no_var/2)* (randn(size(s)) + 1i * randn(size(s)));
    
    s = observ_mat * h_corr + noise;
    
%     % Compute received signal for each pilot signal duration t
%     for i = 1:T
%        
%         % generate AWGN with power = no_var
%         noise = sqrt(no_var/2)* (randn(num_rx_ant,num_tx_ant) + 1i * randn(num_rx_ant,num_tx_ant));
%         
%         start_row = (i-1)*num_rx_ant;
%         end_row = i*num_rx_ant;
%         s(start_row:end_row,:) = observ_mat(start_row:end_row,:) * h_corr + noise;
%     end
    
end
