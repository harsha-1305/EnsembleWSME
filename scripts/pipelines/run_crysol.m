function run_crysol() 
    foldername = "..\results\microstates\";
    folders = dir(foldername);
    n = length(folders);
    
    parfor i = 3:n
        folder_path = foldername + folders(i).name + '\';
        ranch_path = folder_path + "ranch\";
        crysol_path = folder_path + "crysol\";
        mkdir(crysol_path);
        rmdir(crysol_path, 's');
        mkdir(crysol_path);
        
        ranch_files = dir(ranch_path);
        ranch_files = ranch_files(3:end);
    
        batch = 50;
        
        opwd = pwd;
        cd(crysol_path)
        for k = 1:batch:length(ranch_files)
            j_max = min(k+batch-1, length(ranch_files));
            command = "crysol ";
    
            for j = k:j_max
                command = command + ranch_files(j).folder+"\"+ ranch_files(j).name + " ";
            end
    
            command = command + ' --lm=25 --ns=301 --smax=0.3';
    
            [status, cmdout] = system(command);
        end
        cd(opwd)
        
        disp(sprintf('%d of %d', i-2, n-2) + " done")
    end
    
    disp("Main 3 Done")
end