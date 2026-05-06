function a = a_s(v_s, at_s, r, s)
    ar = v_s(s)^2 / r;
    a = sqrt(ar^2 + at_s(s)^2);
end