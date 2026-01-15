function [x, y] = vis_crysol_nonan
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
    
        if ~anynan(yi)
            y = y + yi.*mis(8);
        end
        disp(sprintf('%d of %d', i-2, length(folders)-2) + " done")
    end
    
    disp("Main 4 Done")
end