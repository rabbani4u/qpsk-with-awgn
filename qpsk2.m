num_bits = 1e6; % Number of bits to transmit
EbNo_dB = 0:2:12; % Eb/No values to test in dB
M = 4; % QPSK modulation order
k = log2(M); % Number of bits per symbol
SNR_dB = EbNo_dB + 10*log10(k); % SNR in dB
errors = zeros(size(SNR_dB)); % Bit error rate (BER) for each Eb/No

%% Transmitter
tx_bits = randi([0 1], 1, num_bits); % Generate random bits
tx_symbols = qammod(tx_bits, M); % QPSK modulation

%% Channel
for i = 1:length(SNR_dB)
    snr = 10^(SNR_dB(i)/10); % Convert SNR from dB to linear scale
    noise_var = 1/(2*snr); % Noise variance
    rx_symbols = awgn(tx_symbols, snr, 'measured'); % Add AWGN
    rx_bits = qamdemod(rx_symbols, M); % QPSK demodulation
    errors(i) = biterr(tx_bits, rx_bits); % Count bit errors
end

%% Results
BER = errors/num_bits; % Bit error rate
semilogy(EbNo_dB, BER); % Plot BER vs. Eb/No
xlabel('Eb/No (dB)'); ylabel('Bit Error Rate');
grid on;