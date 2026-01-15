function [x, y] = load_crysol_data(path, n, pltall, alpha)
    x = zeros(1, n);
    y = zeros(1, n);

    files = dir(fullfile(path, '*.abs'));

    if pltall == 1
        hold on
    end
    for i = 1:length(files)
        file_path = path + files(i).name;

        data = split(fileread(file_path));
        data = data(3:end);

        x_temp = str2double(reshape(data(1:2:(end-1), :), 1, []));
        x = x_temp.*10; % A-1 to nm-1
        % y = y + str2double(reshape(data(2:2:end, :), 1, []));

        y_temp = str2double(reshape(data(2:2:end, :), 1, []));
        y = y + y_temp;
        if pltall == 1
            p1 = plot(x, y_temp.*x.*x);
            p1.Color = [p1.Color alpha];
        end
    end
    y = y./length(files);

    if pltall == 1
        title("Kratky plot of SAXS data")
        xlabel("q(nm^-1)")
        ylabel("I(q).q^2")
    end
end