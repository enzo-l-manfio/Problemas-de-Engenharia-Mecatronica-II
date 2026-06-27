clear;

%%Importar Função de Resolver EDO
SolucaoEDO = @SolucaoEDO;

m = 2 + 02/100;
k = 1000;
omega = sqrt(k/m);
omega_amortecido = sqrt(k/m - (5^2)/(4 * m^2));
omega_amortecido_hz = omega_amortecido/(2 * pi);
disp(omega_amortecido_hz);
fs = 200;
dt = 1/fs;
t = 0:dt:10;
N = length(t);

impulso = @(t) 1/dt * double((t < dt & t>=0));

configuracoes = {0 @(t) 0;
                 5 @(t) 0;
                 5 @(t) 5*sin(t*omega/2);
                 5 @(t) 5*sin(t*omega);
                 0 @(t) 5*sin(t*omega);
                 5 impulso};


pos = zeros(N, 1);
vel = zeros(N, 1);

titulos_y = ["$x(m)$", "$\dot{x}(m/s)$"];

n = 1;
for i = 1:2:11
    c = configuracoes{n, 1};
    f = configuracoes{n, 2};
    if n == 6
        v0 = 0;
    else
        v0 = 10;
    end

    [pos, vel] = SolucaoEDO(m, c, k, f, 0, v0, t);
    result = [pos, vel];

    figure(i);
    for j=1:2
        subplot(2, 1, j);
        plot(t, result(:, j));
        hold on;
        [pks, locs] = findpeaks(result(:, j), t, 'MinPeakProminence', 0.01);
      
        l = length(locs);
        if l >= 2
            if n == 3 || n == 4
                s = l - 1;
            else
                s = 1;
            end
            xline(locs(s), '--k', 'LineWidth', 0.5);
            xline(locs(s+1), '--k', 'LineWidth', 0.5);
            plot(locs(s:s+1), pks(s:s+1), 'r.', 'MarkerFaceColor', 'r', 'MarkerSize', 30);
            
        end
        
        ylabel(titulos_y(j), 'Interpreter', 'latex');
        xlabel('t (s)');
        xlim([0 10]);
        set(gca, 'FontSize', 30);
    end
    figure(i + 1)
    plot(result(:, 1), result(:, 2));
    hold on;
    p_i = plot(result(1, 1), result(1, 2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Ponto Inicial');
    p_f = plot(result(end, 1), result(end, 2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'DisplayName', 'Ponto Final');
    xlabel(titulos_y(1), 'Interpreter','latex');
    ylabel(titulos_y(2), 'Interpreter','latex');
    legend([p_i, p_f], 'Ponto Inicial', 'Ponto Final');
    set(gca, 'FontSize', 30);
    n = n + 1;
end
P = fft(pos);
I = fft(impulso(t));
H = P./I ;
H_norm = abs(H);
H_ang = unwrap(angle(H));

df = fs/N;
freq = 0:df:fs-df;

figure(13)
plot(freq, H_norm);
xline(omega_amortecido_hz, '--r', 'Label', '$\omega_0$', 'Interpreter', 'latex', 'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'bottom', 'FontSize', 30);
ylabel('Amplitude (m)');
xlabel('Frequência');
set(gca, 'FontSize', 30);
xlim([0, fs/2]);


figure(14)
yyaxis left
loglog(freq, 20*H_norm)
ylabel('Amplitude (dB)', 'Interpreter', 'latex');
yyaxis right
semilogx(freq, H_ang);
ylabel('Fase (rad)');
xline(omega_amortecido_hz, '--r', 'Label', '$\omega_0$', 'Interpreter', 'latex', 'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'bottom', 'FontSize', 30);

xlabel('Frequência (Hz)', 'Interpreter', 'latex');
xlim([0 fs/2])
grid on;
set(gca, 'FontSize', 30);

