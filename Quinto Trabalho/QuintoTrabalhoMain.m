SolucaoEDO = @SolucaoEDO;

m = 2 + 02/100;
k = 1000;
omega = sqrt(k/m);

impulso = @(t) double((t <= 0));

configuracoes = {0 @(t) 0;
                 5 @(t) 0;
                 5 @(t) 5*sin(t*omega/2);
                 5 @(t) 5*sin(t*omega);
                 0 @(t) 5*sin(t*omega);
                 5 impulso};

dt = 0.01;
t = 0:dt:10;
N = length(t);

pos = zeros(N, 1);
vel = zeros(N, 1);
ac = zeros(N, 1);

titulos_y = ["$x$", "$\dot{x}$", "$\ddot{x}$"];

for i = 1:5
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


c = configuracoes{6, 1};
f = configuracoes{6, 2};
[pos, vel, ac] = SolucaoEDO(m, c, k, f, 0, 10, t);

Y = fft(pos);
Y_norm = 2/N*abs(Y);

fs = 1/dt;
df = fs/N;
freq = 0:df:fs-df;

figure(6);
plot(freq, Y_norm);
ylabel(titulos_y(1), 'Interpreter', 'latex');
ylabel(titulos_y(2), 'Interpreter', 'latex');
xlim([0 fs])
set(gca, 'FontSize', 30);
