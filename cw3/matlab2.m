% Parametry sygnału
fc = 225e3;       % nośna [Hz]
fm = 10e3;        % modulujący [Hz]
fs = 1e6;         % częstotliwość próbkowania
t = 0:1/fs:1e-3;  % 1 ms sygnału

carrier = cos(2*pi*fc*t);
modulating = cos(2*pi*fm*t);

m_values = [0.1, 0.5, 1, 1.5];

%% --- Figura 1: sygnały czasowe ---
figure('Name','Sygnały AM w dziedzinie czasu','NumberTitle','off');
set(gcf,'Position',[100 100 800 1000]) % powiększ okno

for k = 1:length(m_values)
    m = m_values(k);
    s = (1 + m*modulating) .* carrier;
    
    subplot(length(m_values),1,k)
    plot(t*1e3, s)
    title(['Sygnał AM, m = ', num2str(m)])
    xlabel('Czas [ms]')
    ylabel('Amplituda')
    grid on
    xlim([0 0.2]) % pokaż pierwsze 0.2 ms
end
sgtitle('Sygnały AM - sygnał w dziedzinie czasu')

%% --- Figura 2: widma amplitudowe ---
figure('Name','Widma amplitudowe sygnałów AM','NumberTitle','off');
set(gcf,'Position',[100 100 800 1000]) % powiększ okno

for k = 1:length(m_values)
    m = m_values(k);
    s = (1 + m*modulating) .* carrier;
    
    N = length(s);
    S = fft(s);
    f = (0:N-1)*(fs/N);
    S_mag = abs(S)/N;
    S_mag(2:end-1) = 2*S_mag(2:end-1); % korekta amplitudy
    
    idx_limit = f <= 300e3;
    f_plot = f(idx_limit);
    S_plot = S_mag(idx_limit);
    
    subplot(length(m_values),1,k)
    plot(f_plot/1e3, S_plot, 'b-', 'LineWidth', 1.2)
    xlim([0 300])
    ylim([0 1.2*max(S_plot)])
    grid on
    title(['Widmo amplitudowe AM, m = ', num2str(m)])
    xlabel('Częstotliwość [kHz]')
    ylabel('Amplituda')
    legend('Widmo')
end
sgtitle('Widma amplitudowe sygnałów AM')

