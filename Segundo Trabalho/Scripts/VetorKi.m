function k_i = VetorKi(n, k_min, delta_k, b)
    k_i = zeros(n, 1);
    for i = 1:n
        k_i(i) = k_min + delta_k*exp(-b*i);
    end
end