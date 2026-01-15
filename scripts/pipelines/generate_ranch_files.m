function generate_ranch_files(pname, n, split) 
    sub_name = "A";
    % Protein sequence | A2AA_ref = atoms to amino acids reference
    [len, seq, A2AA_ref] = gen_seq(pname + ".pdb");

    % MIS_strb = microstates in structural blocks;
    MIS_strb = peak_microstates(pname + "_pepval.mat", n, split);
    % structured blocks to residues (sb2r) reference
    SB2R_REF = strb2res_ref(pname + "_BlockDet.dat");
    % convert strb mis to residue (res) mis
    MIS_res = strb2res_mis(MIS_strb, SB2R_REF);
    % generate assignment texts
    ASSMTS = res2assmts(MIS_res, len, sub_name);
    % common sequence string
    SEQ_txt = "> " + sub_name + newline + seq;
    % native pdb structure
    pdb_data = pdbread(pname + ".pdb");

    % Generate all ranch-ready files
    foldername = "..\results\microstates\";
    mkdir(foldername);
    rmdir(foldername, 's');
    mkdir(foldername);

    for i = 1:length(ASSMTS)
        mis = MIS_res(i, :);
        path = foldername + sprintf('%05d_%d_%d_%0.4f',i, mis(1), mis(7), mis(8)) + "\";
        mkdir(path);
        mkdir(path + "ranch");
        mkdir(path + "crysol");
        writematrix(SEQ_txt, path + 'sequence.seq', 'FileType', 'text');
        writematrix(ASSMTS(i), path + 'assignment.txt');
        generate_dom_pdbs(mis, pdb_data, A2AA_ref, path);
        save(path + 'microstate_info.mat', "mis")
    end
    
    disp("Main 1 Done")
end