function t = t_s(v_s, s0, sf)
    inversa_v = @(s) 1./v_s(s);
    t = integral(inversa_v, s0, sf);
end