
MatrizRigidez = @MatrizRigidez;
VetorKi = @VetorKi;

k_min = 30*10^3;
delta_k = (70 + 04)*10^3;
b = 0.15;

n_1 = 30;
n_2 = 10;
n = [n_1; n_2];

F_1 = zeros(n_1, 1);
F_1(n_1) = 50;

F_2 = zeros(n_2, 1);
F_2(n_2) = 100;
F_2(5) = -50;

F = {F_1; F_2};

disp(F{2})

for j = 1:2
    k = VetorKi(n(j), k_min, delta_k, b);
    M = MatrizRigidez(k);
    u = linsolve(M, F{j});
    disp(u)
    i = 1:n(j);

    figure(j)

    subplot(2, 1, 1);
    plot(i, k);
    hold on;
    title(['Rigidez de cada elemento for n = ', num2str(n(j))]);
    xlabel('Element Index');
    ylabel('Stiffness (N/m)');
    grid on;

    subplot(2, 1, 2);
    plot(i, u);
    ylabel('Displacement (m)');
    title(['Displacement for n = ', num2str(n(j))]);
    hold off;
end
