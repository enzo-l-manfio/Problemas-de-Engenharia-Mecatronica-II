SolucaoEDO = @SolucaoEDO;

m = 2 + 02/100;
k = 1000;
omega = sqrt(k/m);

impulso = @(t) double((t == 0));

configuracoes = {0 @(t) 0;
                 5 @(t) 0;
                 5 @(t) 5*sin(t*omega/2);
                 5 @(t) 5*sin(t*omega);
                 0 @(t) 5*sin(t*omega);
                 5 impulso};

f_max = 4000;
dt = 1/f_max;
t = 0:dt:10;
N = length(t);

pos = zeros(N, 1);
vel = zeros(N, 1);
ac = zeros(N, 1);

titulos_y = ["$x$", "$\dot{x}$", "$\ddot{x}$"];

for i = 1:6
    c = configuracoes{i, 1};
    f = configuracoes{i, 2};
    [pos, vel, ac] = SolucaoEDO(m, c, k, f, 0, 10, t);
    result = [pos, vel, ac];

    figure(i);
    for j=1:3
        subplot(3, 1, j);
        plot(t, result(:, j));
        hold on;
        ylabel(titulos_y(j), 'Interpreter', 'latex');
        xlabel('t');
        xlim([0 10]);
        set(gca, 'FontSize', 30);
    end
    hold off;
end


w = hann(N);
pos_6_w = pos.*w ;
Y = fft(pos_6_w);
Y_6_norm = 2/N*abs(Y);
    

df = f_max/N;
freq = 0:df:f_max-df;

figure(7);
plot(freq, Y_6_norm);
ylabel('Amplitude', 'Interpreter', 'latex');
xlabel('Frequência (Hz)', 'Interpreter', 'latex');
xlim([0 f_max/2])
set(gca, 'FontSize', 30);

figure(8)
loglog(freq, Y_6_norm)
ylabel('Amplitude', 'Interpreter', 'latex');
xlabel('Frequência (Hz)', 'Interpreter', 'latex');
xlim([0 f_max/2])
grid on;
set(gca, 'FontSize', 30);

figure(9)
semilogx(freq, angle(Y))
ylabel('Fase (rad)', 'Interpreter', 'latex');
xlabel('Frequência (Hz)', 'Interpreter', 'latex');
xlim([0 f_max/2])
grid on;
set(gca, 'FontSize', 30);
