R = 50;
L = 70*10^(-6);
C = 80*10^(-12);

omega_rez = 1./sqrt(L*C);

f_rez = 1./(2*pi*sqrt(L*C));

f = linspace(0.9*f_rez, 1.1*f_rez, 1e4);
omega = 2*pi*f;

X = omega*L- 1./(omega*C);

Z = R + j*X;

figure(1)
plot(f, abs(Z))

figure(2)
plot(f, angle(Z))

%---

f_1 = 10*10^3;

t = linspace(0, 4/f_1, 1e4);

omega_1 = 2 * pi * f_1;
y_1 = sin(omega_1*t) + 0.5*sin(2*omega_1*t);
plot(y_1)

% --- Widmo amplitudowe ---
N = length(y_1);
Y = fft(y_1);
Y_amp = abs(Y) / N;
Y_amp(2:end-1) = 2 * Y_amp(2:end-1);  % korekta amplitudy
fs = 1 / (t(2) - t(1));
f_axis = (0:N-1) * (fs / N);

figure(3)
plot(f_axis(1:N/2), Y_amp(1:N/2))
xlabel('Częstotliwość [Hz]')
ylabel('Amplituda')
title('Widmo amplitudowe sygnału')
grid on
xlim([-2 1000])

%----

n5 = 0:5;
n10 = 0:10;
n500 = 0:500;

y_rect_5 = zeros(size(t));  % Initialize the output array
for n = n5
    y_rect_5 = y_rect_5 + sin((2*n+1)*omega_1*t) / (2*n+1);
end

figure(4)
plot(t, y_rect_5)

y_rect_10 = zeros(size(t));  % Initialize the output array
for n = n10
    y_rect_10 = y_rect_10 + sin((2*n+1)*omega_1*t) / (2*n+1);
end

figure(5)
plot(t, y_rect_10)

y_rect_500 = zeros(size(t));  % Initialize the output array
for n = n500
    y_rect_500 = y_rect_500 + sin((2*n+1)*omega_1*t) / (2*n+1);
end

figure(6)
plot(t, y_rect_500)

%-----

% Wspólna oś częstotliwości
f_axis = (0:N-1) * (fs / N);

% Widmo dla 5 składników
Y5 = fft(y_rect_5);
Y5_amp = abs(Y5) / N;
Y5_amp(2:end-1) = 2 * Y5_amp(2:end-1);  % poprawka amplitudy

% Widmo dla 10 składników
Y10 = fft(y_rect_10);
Y10_amp = abs(Y10) / N;
Y10_amp(2:end-1) = 2 * Y10_amp(2:end-1);

% Widmo dla 500 składników
Y500 = fft(y_rect_500);
Y500_amp = abs(Y500) / N;
Y500_amp(2:end-1) = 2 * Y500_amp(2:end-1);

% --- Rysowanie widm ---
figure(7)
plot(f_axis(1:N/2), Y5_amp(1:N/2))
xlim([0 100e3])
title('Widmo amplitudowe – 5 składników')
xlabel('Częstotliwość [Hz]')
ylabel('Amplituda')
grid on
xlim([-2 1000])

figure(8)
plot(f_axis(1:N/2), Y10_amp(1:N/2))
xlim([0 100e3])
title('Widmo amplitudowe – 10 składników')
xlabel('Częstotliwość [Hz]')
ylabel('Amplituda')
grid on
xlim([-2 1000])

figure(9)
plot(f_axis(1:N/2), Y500_amp(1:N/2))
xlim([0 300e3])  % szerszy zakres, więcej harmonicznych
title('Widmo amplitudowe – 500 składników')
xlabel('Częstotliwość [Hz]')
ylabel('Amplituda')
grid on
xlim([-2 1000])

%----trojkatne
% --- Sygnał trójkątny – 5 składników ---
y_tri_5 = zeros(size(t));
for n = n5
    y_tri_5 = y_tri_5 + ((-1)^n) * sin((2*n+1)*omega_1*t) / (2*n+1)^2;
end
y_tri_5 = (8 / pi^2) * y_tri_5;

figure(10)
plot(t, y_tri_5)
title('Trójkątna fala – 5 składników')
xlabel('Czas [s]')
ylabel('Amplituda')
grid on

% --- Sygnał trójkątny – 10 składników ---
y_tri_10 = zeros(size(t));
for n = n10
    y_tri_10 = y_tri_10 + ((-1)^n) * sin((2*n+1)*omega_1*t) / (2*n+1)^2;
end
y_tri_10 = (8 / pi^2) * y_tri_10;

figure(11)
plot(t, y_tri_10)
title('Trójkątna fala – 10 składników')
xlabel('Czas [s]')
ylabel('Amplituda')
grid on

% --- Sygnał trójkątny – 500 składników ---
y_tri_500 = zeros(size(t));
for n = n500
    y_tri_500 = y_tri_500 + ((-1)^n) * sin((2*n+1)*omega_1*t) / (2*n+1)^2;
end
y_tri_500 = (8 / pi^2) * y_tri_500;

figure(12)
plot(t, y_tri_500)
title('Trójkątna fala – 500 składników')
xlabel('Czas [s]')
ylabel('Amplituda')
grid on