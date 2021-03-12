function inl_p = apply_H(H, inl)

    inl_p = dehom(H*hom(inl));

end