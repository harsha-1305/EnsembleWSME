function [x, y] = vis_crysol(pname)
    clf('reset')
    hold on
    foldername = "..\results\microstates\";
    folders = dir(foldername);

    n = 301;
    
    x = [];
    y = zeros(1, n);
    
    for i = 3:length(folders)
        folder_path = foldername + folders(i).name + '\';
        crysol_path = folder_path + "crysol\";
        
        mis = load(folder_path + "microstate_info.mat");
        mis = mis.mis;
        
        [x, yi] = load_crysol_data(crysol_path, n, 0, mis(8));
    
        y = y + yi.*mis(8);
        disp(sprintf('%d of %d', i-2, length(folders)-2) + " done")
    end

    data = readmatrix("..\data\" + pname + "_SAXS.dat");
    x_exp = data(4:end, 1).';
    y_exp = data(4:end, 2).';
    y_err = data(4:end, 3).';
    c = 453;
    x_exp = x_exp(1:c);
    y_exp = y_exp(1:c);
    y_err = y_err(1:c);

    lgd = [];
    p1 = errorbar(x_exp, y_exp, y_err, 'o');
    p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"Experimental"}, size(p1.XData)));
    lgd = [lgd "Experimental"];
    title("Kratky plot of SAXS data")
    xlabel("q(nm^-1)")
    ylabel("I(q).q^2")
    yscale log

    [x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
    p1 = plot(x_fit, y_fit);
    p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat("Predicted", size(p1.XData)));
    lgd = [lgd "Predicted"];
    legend(lgd)
    
    disp("Main 4 Done")
end