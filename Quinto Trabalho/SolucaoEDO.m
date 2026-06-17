function [pos, vel, ac] = SolucaoEDO(m, c, k, f, pos0, vel0, t)

    MatrizEstados = [0 1;
                     -k/m -c/m];
    dydt = @(t, y) MatrizEstados *y + [0; f(t)/m];
    
    [t, y] = ode45(dydt, t, [pos0 vel0]);
    pos = y(:, 1);
    vel = y(:, 2);
   
    ac = gradient(vel, t);
end