
MatrizRigidez = @MatrizRigidez;
VetorKi = @VetorKi;

k_min = 30*10^3; %N/m
delta_k = (70 + 0.2 * 02)*10^3; %N/m
b = 0.15;

n_1 = 30;
n_2 = 10;
n = [n_1; n_2];

F_1 = zeros(n_1, 1);
F_1(n_1) = 50;

F_2 = zeros(n_2, 1);
F_2(n_2) = 100;
F_2(n_2/2) = -50;

F = {F_1; F_2};

for j = 1:2
    k = VetorKi(n(j), k_min, delta_k, b);
    M = MatrizRigidez(k);
    u = linsolve(M, F{j});
    
    i = 1:n(j);

    k = k/1000; %Converter para kN/m
    u = u*1000; %Converter para mm
    figure(j)
    

    subplot(2, 1, 1);
    plot(i, k, 'LineWidth' , 1.5);
    hold on;
    title(['Rigidez de cada elemento para n = ', num2str(n(j))], FontName="Times New Roman");
    xlabel('Índice do Elemento');
    ylabel('Rigidez (kN/m)');
    set(gca, 'FontSize', 30, fontname="Times New Roman")
    grid on;

    subplot(2, 1, 2);
    plot(i, u,'LineWidth' , 1.5);
    xlabel('Índice do Elemento', FontName="Times New Roman");
    ylabel('Deslocamento (mm)', FontName="Times New Roman");
    title(['Deslocamento de cada elemento para n = ', num2str(n(j))], FontName="Times New Roman");
    set(gca, 'FontSize', 30, fontname="Times New Roman")
    grid on;
    hold off;
end
