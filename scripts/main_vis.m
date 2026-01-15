init

pname = 'TipASm';

% Run disp_blocks(pname) in console to visualize graph to assign splits

% Mode 1 : Pool generation - Use for visualizing ensembles
split = [4 9; 16 19; 21 27; 28 33]; % Split blocks into pools
n = 5; % No. of microstates considered per pool
reps = 5; % No. of conformers to be generated per microstate
generate_ranch_files(pname, n, split);
run_ranch(pname, reps)
make_pools(split, n);

% % Mode 2 : Top microstates generation - Use for SAXS fitting
% split = 0; % Signifies Mode 2
% n = 10; % No. of microstates to consider
% reps = 30; % No. of conformers to be generated per microstate
% generate_ranch_files(pname, n, split);
% run_ranch(pname, reps);
% run_crysol();
% % Note : Edit vis_crysol directly on the basis of experimental SAXS data
% % format and required graph format
% [x, y] = vis_crysol(pname);

disp("Finished.")

