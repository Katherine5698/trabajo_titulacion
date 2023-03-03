function evm = calculate_EVM( tx_signal, rx_signal)
% This function calculates the Error Vector Magnitude (EVM) for the received GFDM signal
% using the transmitted GFDM signal as reference.


% Calculate EVM
error_vector = tx_signal - rx_signal;
evm = sqrt(mean(abs(error_vector).^2)) / sqrt(mean(abs(tx_signal).^2))*100;

end

