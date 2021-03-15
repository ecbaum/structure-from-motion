function inl_p = apply_H(H, pts)

    inl_p = dehom(H*hom(pts));

end