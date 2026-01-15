function run_ranch(pname, reps)     
    foldername = "..\results\microstates\";
    folders = dir(foldername);
    n = length(folders);
    reps = string(reps);
    
    parfor i = 3:n
        folder_path = foldername + folders(i).name + '\';
        ranch_path = folder_path + "ranch\";
        mkdir(ranch_path);
        rmdir(ranch_path, 's');
        mkdir(ranch_path);
        
        mis = load(folder_path + "microstate_info.mat");
        mis = mis.mis;
        
        if mis(7) == 1
            seq = readlines(folder_path+"sequence.seq");
            seq = strlength(seq(2));
            ast = readlines(folder_path+"assignment.txt");
            ast = split(ast(2));
        
            if str2double(ast(3)) ~= seq
                command = 'ranch --repetitions '+reps+' --model-format=cif --prefix '+ranch_path+sprintf('%d_%d_%d_ ', mis(1), mis(7), mis(2))+folder_path+'assignment.txt '+folder_path+'sequence.seq '+folder_path+'dom1.pdb';
                [status, ~] = system(command);
            else
                copyfile("..\data\"+pname+".cif", ranch_path) 
                status = movefile(ranch_path+pname+".cif", ranch_path+sprintf('%d', mis(1))+'_'+sprintf('%d',mis(7))+'_00001.cif');
            end
        else
            command = 'ranch --repetitions '+reps+' --model-format=cif --prefix '+ranch_path+sprintf('%d_%d_%d_ ', mis(1), mis(7), mis(2))+folder_path+'assignment.txt '+folder_path+'sequence.seq '+folder_path+'dom1.pdb '+folder_path+'dom2.pdb';
            [status, ~] = system(command);
        end
    
        disp(sprintf('%d of %d', i-2, n-2) + " done with status " + sprintf('%d', status))
    end
    
    disp("Main 2 Done")
end