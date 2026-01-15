function fin_microstates = top_10by10_microstates(filename)
    imp_mi_info = load(filename);
    imp_mi_info = imp_mi_info.pepval;
    mi_info = [imp_mi_info(:, 1:2) reshape(1:size(imp_mi_info, 1), [], 1)]; % col_1 = no. of str blocks; col_2 = stat weight; col_3 = index
    
    % distributing acc to no. of structured blocks
    [~, most_rep] = mode(mi_info(:, 1));
    mi_info_sort = zeros(most_rep, max(mi_info(:, 1)), 2); % col = no. of structured blocks
    for i = 1:size(mi_info_sort, 2)
        matches = (mi_info(:, 1) == i);
        entries = mi_info(matches, 2);
        indices = mi_info(matches, 3);
        mi_info_sort(1:size(entries, 1), i, 1) = entries;
        mi_info_sort(1:size(indices, 1), i, 2) = indices;
    end

    % sorting along 2 dimensions
    [mi_info_sort(:, :, 1), order] = sort(mi_info_sort(:, :, 1), 'descend');
    for i = 1:size(mi_info_sort, 2)
        mi_info_sort(:, i, 2) = mi_info_sort(order(:, i), i,  2);
    end
    [~, order_2] = sort(sum(mi_info_sort(:, :, 1), 1), 'descend');
    mi_info_sort(:, :, :) = mi_info_sort(:, order_2, :);

    % Design decision - top 10 macrostates, top 10 microstates in each
    indices = reshape(mi_info_sort(1:10, 1:10, 2), 1, []);
    fin_microstates = imp_mi_info(indices, :);
end