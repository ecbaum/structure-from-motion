function ave = reprojection_error(pts, H1, H2)


diff = apply_H(H1, pts) - apply_H(H2, pts);
errors = sqrt(diff(1,:).^2 + diff(2,:).^2);
ave = mean(errors);