function fin_mis = peak_microstates(filename, n, split)
    raw_data = load(filename);
    raw_data = raw_data.pepval;
    
    fin_mis = [];

    if ~isscalar(split)
        for i = 1:size(split, 1)
            reps_ens = raw_data(find(raw_data(:, 1) >= split(i, 1) & raw_data(:, 1) <= split(i, 2)), :);
            reps_ens = sortrows(reps_ens, 2, 'descend');
    
            fin_mis = [fin_mis; reps_ens(1:n, :)];
        end
        fin_mis = [fin_mis fin_mis(:, 2)./sum(fin_mis(:, 2))];
    else
        raw_data = sortrows(raw_data, 2, 'descend');
        fin_mis = raw_data(1:n, :);
        fin_mis = [fin_mis fin_mis(:, 2)./sum(fin_mis(:, 2))];
        fprintf("%f%% of microstates considered.\n", sum(raw_data(1:n, 2))*100/sum(raw_data(:, 2)))
        x = input("Proceed? Y/N [Y]: ", "s");
        if isempty(x)
            x = "Y";
        end
        if x == "N"
            error("Error : User abort")
        end
    end
end