% Parametry sygnału
fc = 225e3;       % częstotliwość nośna [Hz]
fm = 10e3;        % częstotliwość modulująca [Hz]
fs = 1e6;         % częstotliwość próbkowania
t = 0:1/fs:1e-3;  % czas (1 ms)

% Współczynniki modulacji beta
beta_values = [0.1, 0.5, 1, 1.5];

%% --- Figura 1: sygnały FM w dziedzinie czasu ---
figure('Name','Sygnały FM - dziedzina czasu','NumberTitle','off');
set(gcf, 'Position', [100 100 800 1000]);

for k = 1:length(beta_values)
    beta = beta_values(k);
    
    % Generacja sygnału FM
    s_fm = cos(2*pi*fc*t + beta * sin(2*pi*fm*t));
    
    subplot(length(beta_values), 1, k)
    plot(t*1e3, s_fm)
    title(['FM, \beta = ', num2str(beta)])
    xlabel('Czas [ms]')
    ylabel('Amplituda')
    xlim([0 0.2])
    grid on
end
sgtitle('Sygnały FM w dziedzinie czasu')

%% --- Figura 2: widma FM ---
figure('Name','Widma amplitudowe FM','NumberTitle','off');
set(gcf, 'Position', [100 100 800 1000]);

for k = 1:length(beta_values)
    beta = beta_values(k);
    
    % Sygnał FM
    s_fm = cos(2*pi*fc*t + beta * sin(2*pi*fm*t));
    
    % FFT
    N = length(s_fm);
    S = fft(s_fm);
    f = (0:N-1)*(fs/N);
    S_mag = abs(S)/N;
    S_mag(2:end-1) = 2*S_mag(2:end-1);
    
    % Ograniczenie zakresu do 300 kHz
    idx_limit = f <= 300e3;
    f_plot = f(idx_limit);
    S_plot = S_mag(idx_limit);
    
    subplot(length(beta_values), 1, k)
    plot(f_plot/1e3, S_plot, 'b', 'LineWidth', 1.2)
    title(['Widmo FM, \beta = ', num2str(beta)])
    xlabel('Częstotliwość [kHz]')
    ylabel('Amplituda')
    xlim([0 300])
    ylim([0 1.2*max(S_plot)])
    grid on
end
sgtitle('Widma amplitudowe sygnałów FM')
