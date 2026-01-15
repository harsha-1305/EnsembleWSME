function make_pools(split, no)
    foldername = "..\results\microstates\";
    folders = dir(foldername);
    folders = folders(3:end);
    n = length(folders);

    pool_dir = "..\results\pools\";
    mkdir(pool_dir);
    rmdir(pool_dir, 's');
    mkdir(pool_dir);

    % Move ranch files into pools
    folderindex = 0;
    for i = 1:size(split, 1)
        curpoolpath = pool_dir+"pool_"+string(i);
        mkdir(curpoolpath);
        rmdir(curpoolpath, 's');
        mkdir(curpoolpath);

        for j = 1:no
            folderindex = folderindex + 1;
            curfolder = folders(folderindex);

            ranchPath = fullfile(curfolder.folder, curfolder.name, 'ranch');
            cifFiles = dir(fullfile(ranchPath, '*.cif'));
            for k = 1:numel(cifFiles)
                srcFile = fullfile(cifFiles(k).folder, cifFiles(k).name);
                copyfile(srcFile, curpoolpath);
            end
        end
    end
    
    % Move microstate info files for future reference
    for i = 1:n
        folders_list = dir(foldername+sprintf("%05d", i)+"_*");
        req_path = fullfile(folders_list(1).folder, folders_list(1).name);
        pool_path = pool_dir + "pool_" + string(floor((i-1)/no) + 1) + "\";
        copyfile(fullfile(req_path, "microstate_info.mat"), pool_path+string(i)+".mat")
    
        if mod(i, no) == 0
            fileList = dir(pool_path + "*.mat");
            numFiles = numel(fileList);
            collectedData = cell(numFiles, 1);
            
            for k = 1:numFiles
                temp = load(pool_path + fileList(k).name);
                collectedData{k} = temp.mis; 
            end
            
            % 5. Save the combined variable(s) to a new .mat file
            % 'finalMatrix' will be the variable name in the new file
            save(pool_dir+"pool_"+string(floor((i-1)/no) + 1)+".mat", 'collectedData');
            delete(fullfile(pool_path, '*.mat'));
        end
    end
    disp("Done")
end