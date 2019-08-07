function Y = classification_with_smooth_potential(u, D, V,omega_0,epsilon,dt,c,MAX_ITER,tolit)
    [u1,it] = convexity_splitting_vector(u, D, V,omega_0,epsilon,dt,c,MAX_ITER,tolit);
    [~,Y]   = max(u1,[],2); % get classification