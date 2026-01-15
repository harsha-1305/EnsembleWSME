function [x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err)
    % (Optional but recommended) define q-range to fit
    qmin = min(x_exp);
    qmax = max(x_exp);
    
    fit_idx = (x_exp >= qmin) & (x_exp <= qmax);
    
    x_fit    = x_exp(fit_idx);
    y_fitexp = y_exp(fit_idx);
    y_sigma  = y_err(fit_idx);
    
    % Interpolate calculated SAXS onto experimental q-grid
    Icalc_interp = interp1(x, y, x_fit, 'linear', 'extrap');
    
    % Build weighted least-squares system
    % Model: I_exp = mu * I_calc + delta
    
    A = [Icalc_interp(:), ones(length(Icalc_interp),1)];
    b = y_fitexp(:);
    
    % Weight matrix (inverse variance)
    W = diag(1 ./ (y_sigma(:).^2));
    
    % Solve for mu and delta
    params = (A' * W * A) \ (A' * W * b);
    
    mu    = params(1);
    delta = params(2);
    
    % Generate fitted curve (on experimental q grid)
    x_fit = x_exp;
    y_fit = mu * Icalc_interp + delta;
    % x_fit = x;
    % y_fit = y;
end