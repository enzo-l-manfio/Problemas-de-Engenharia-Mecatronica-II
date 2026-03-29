syms u h_i k d g m 

h = h_i - u;

L1_i = sqrt(d^2 + h_i^2);
L2_i = sqrt((2*d)^2 + (h_i)^2);
L1_f = subs(L1_i, h_i, h);
L2_f = subs(L2_i, h_i, h);

F1_y = h*k*(L1_i - L1_f)/L1_f;
F2_y = subs(F1_y, [L1_f, L1_i], [L2_f, L2_i]);

F_el_r = 2*(F1_y + F2_y);

F_r = F_el_r - m*g;
r_ef = diff(F_el_r, u);

expressoes = [F_r, r_ef];
disp(expressoes)

[h_i_num, k_num, d_num, g_num, m_num] = deal(sqrt(0.5^2 - 0.2^2), 15000, 0.2, 9.81, 200 + 80);
intervalo_u = 0:0.0001:h_i_num;
intervalo_u_cm = intervalo_u.*100;

k_n = [0.5*k_num k_num 1.5*k_num];

funcoes = cell(2, 3);
valores_funcoes = zeros(2, 3, length(intervalo_u));
for i = 1:2
    for j = 1:3
        expressao_sub = subs(expressoes(i), [h_i, d, g, m, k], [h_i_num, d_num, g_num, m_num, k_n(j)]); %Substitui variáveis simbólicas por valores numéricos
        funcoes{i, j} = matlabFunction(expressao_sub, 'Vars', u); %Converte expressão simbólica para função
        valores_funcoes(i, j, :) = funcoes{i, j}(intervalo_u)/1000; %Calcula as funções no intervalo de u possíveis, convertendo para KiloNewton
    end
end

raizes_forca = zeros(3, 2);
valores_iniciais = [0, h_i_num];
valores_rigidez = zeros(3, 2);
for i = (1:3)
   for j = (1:2)
       raizes_forca(i, j) = fzero(funcoes{1, i}, valores_iniciais(j));
       valores_rigidez(i, j) = funcoes{2, i}(raizes_forca(i, j)) /1000;
   end
end
disp(raizes_forca)
disp(valores_rigidez)

raizes_rigidez = zeros(3, 1);
for i = (1:3)
    raizes_rigidez(i) = fzero(funcoes{2, i}, 0.27);
end
disp(raizes_rigidez);

for i = (1:2)
    figure(i)

    for j = (1:3)
        plot(intervalo_u_cm, squeeze(valores_funcoes(i, j, :)), "LineWidth", 1.5, 'DisplayName', 'k = ' + string(k_n(j)/1000) + ' kN/m');
        hold on;
    end
    if i == 1
        ylabel('Força Resultante (kN)', FontSize = 20, FontName='Times New Roman');
        title('Força Resultante vs Distensão', FontSize = 20, FontName='Times New Roman');
        for m = (1:3)
            for n = (1:2)
                if m + n == 2
                    visibilidade = 'on';
                else
                    visibilidade = 'off';
                end
                plot(raizes_forca(m, n)*100, 0, 'ro', HandleVisibility=visibilidade, DisplayName='Raízes', LineWidth=1.5)
            end
        end
        ax = gca;
        ax.YLim = [-3, 9];
    else
        ylabel('Resistência Efetiva (kN/m)', FontSize = 20, FontName="Times New Roman");
        title('Resistência Efetiva vs Distensão', FontSize = 20, FontName="Times New Roman");
        for m = (1:3)
            for n = (1:2)
                if m + n == 2
                    visibilidade = 'on';
                else
                    visibilidade = 'off';
                end
                plot(raizes_forca(m, n)*100, valores_rigidez(m, n), 'ro', HandleVisibility=visibilidade, DisplayName='Pontos de Equilíbrio', LineWidth=1.5)
            end
        end
        ax = gca;
        ax.YLim = [-100, 70];
    end
    xlabel('Distensão (cm)', FontName='Times New Roman');
    set(gca, 'FontSize', 20);
    ax.XLim = [0, 46];
    legend show;
    grid on;
end