function Matriz = MatrizRigidez(k)
    n = length(k);
    Matriz = zeros(n, n);
    %Primeira e ultima linhas
    Matriz(1, 1) = k(1);
    Matriz(n, n) = k(n);
    if n>1
        Matriz(1, 1) = k(1) + k(2);
        Matriz(1, 2) = -k(2);
        Matriz(n, n-1) = -k(n);
    end
    if n > 2
        for i = 2:n-1
            Matriz(i, i-1) = -k(i);
            Matriz(i, i) = k(i) + k(i+1) ;
            Matriz(i, i + 1) = -k(i+1);
        end
    end
end