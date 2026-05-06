function v = v_s(s0, v0, at_s, s)
    %Para receber s e retornar v como arrays
    integral_at_ds = arrayfun(@(limite) integral(at_s, s0, limite), s);

    v = sqrt(v0^2 + 2*integral_at_ds);
end