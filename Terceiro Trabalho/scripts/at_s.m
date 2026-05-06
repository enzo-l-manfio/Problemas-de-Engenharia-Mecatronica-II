function a = at_s(N, s)
    a = 4 + 0.01*N*s - 0.01*s.^2 + exp(-s./N);
end