s0 = 0;
N = 02;
v0 = 20 + 0.35*sqrt(N);
r = 100;

at_s_sub = @(s) at_s(N, s);
v_s_sub = @(s) v_s(s0, v0, at_s_sub, s);
a_s_sub = @(s) a_s(v_s_sub, at_s_sub, r, s);

intervalo_s = s0:0.1:30;

v = v_s_sub(intervalo_s);
a = arrayfun(a_s_sub, intervalo_s);
delta_t = t_s(v_s_sub, s0, 21.5);

disp(v_s_sub(28.5));
disp(a_s_sub(28.5));
disp(delta_t);

figure(1)
plot(intervalo_s, v, 'LineWidth' , 1.5);
hold on;
xlabel('Deslocamento (m)');
ylabel('Velocidade (m/s)');
plot(28.5, v_s_sub(28.5), 'r.', 'MarkerSize', 30, 'LineWidth', 1.5);

set(gca, 'FontSize', 30, fontname="Times New Roman")

figure(2)
plot(intervalo_s, a, 'LineWidth' , 1.5);
hold on;
xlabel('Deslocamento (m)');
ylabel('aceleração (m/s²)');
plot(28.5, a_s_sub(28.5), 'r.', 'MarkerSize', 30, 'LineWidth', 1.5);

set(gca, 'FontSize', 30, fontname="Times New Roman");
