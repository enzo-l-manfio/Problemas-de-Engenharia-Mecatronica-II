%% Declaração de Funções

v_t = @(t) 0.025*(155 + 02)*(175-t) / 10^3;

r_teta = @(teta) 0.3*(2 + cos(teta));

dr_dteta= @(teta) -0.3*sin(teta);

velocidade_angular = @(t, teta) v_t(t) ./ sqrt(r_teta(teta).^2 + dr_dteta(teta).^2);

solucao_EDO_teta = @(t_final, dt) ode45(velocidade_angular, 0:dt:t_final, 0);


%% Cálculo

t_final = 26;
dt = 0.01;

[t, teta] = solucao_EDO_teta(t_final, dt);
teta = mod(teta, 2*pi);
r = r_teta(teta);
teta_ponto = velocidade_angular(t, teta);
v = v_t(t);


%% Plotagem de Gráficos

%Gráficos em função do tempo
figure(1)

subplot(2, 2, 1);
plot(t, teta, 'r-', 'LineWidth' , 1.5);
xlim([0 t_final]);
hold on;
xlabel('t (s)')
ylabel('$\theta$ (rad)', 'Interpreter', 'latex')
set(gca, 'FontSize', 40, fontname="Times New Roman")

subplot(2, 2, 2);
plot(t, teta_ponto, 'r-', 'LineWidth' , 1.5);
xlim([0 t_final]);
hold on;
xlabel('t (s)')
ylabel('$\dot{\theta}$ (rad/s)', 'Interpreter', 'latex')
set(gca, 'FontSize', 40, fontname="Times New Roman")

subplot(2, 2, 3);
plot(t, r, 'r-', 'LineWidth' , 1.5);
xlim([0 t_final]);
hold on;
xlabel('t (s)')
ylabel('r (m)')
set(gca, 'FontSize', 40, fontname="Times New Roman")

subplot(2, 2, 4);
plot(t, v, 'r-', 'LineWidth' , 1.5);
xlim([0 t_final]);
hold on;
xlabel('t (s)')
ylabel('v (m/s)')
set(gca, 'FontSize', 40, fontname="Times New Roman")

figure(2)

plot(teta, teta_ponto, 'r-', 'LineWidth' , 1.5);
xlim([0 2*pi])
hold on;
xlabel('$\theta$ (rad)', 'Interpreter','latex')
ylabel('$\dot{\theta}$ (rad/s)', 'Interpreter','latex')
set(gca, 'FontSize', 40, fontname="Times New Roman")


%%Plotagem da Trajetória

figure(3)
polarplot(teta, r, 'r-', 'LineWidth', 1.5)