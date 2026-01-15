init

pname = 'TipASm';

% Mode 2 : Top microstates generation - Use for SAXS fitting
n = 100; % No. of microstates to consider
reps = 30; % No. of conformers to be generated per microstate

split = 0; % Signifies Mode 2
generate_ranch_files(pname, n, split);
run_ranch(pname, reps);
run_crysol();
% Note : Edit vis_crysol directly on the basis of experimental SAXS data
% format and required graph format
[x, y] = vis_crysol(pname);

disp("Finished.")

