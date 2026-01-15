function disp_blocks(pname)
    filename = pname + "_pepval.mat";
    raw_data = load(filename);
    raw_data = raw_data.pepval;

    x = min(raw_data(:, 1)) : max(raw_data(:, 1));
    y = zeros(1, length(x));
    for i = x
        temp = find(raw_data(:, 1) == x(i));
        y(i) = sum(raw_data(temp, 2));
    end
    y = y ./ sum(y);
    clf('reset')
    plot(x, -8.314.*298.*log(y))
    % plot(x, y)
    xlabel("No. of structured blocks")
    ylabel("Delta G (kJ/mol)")
end