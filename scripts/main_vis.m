init

pname = '6Am';

% Run disp_blocks(pname) in console to visualize graph to assign splits

% Mode 1 : Pool generation - Use for visualizing ensembles
split = [4 9; 16 19; 21 27; 28 33]; % Split blocks into pools
n = 5; % No. of microstates considered per pool
reps = 1; % No. of conformers to be generated per microstate
generate_ranch_files(pname, n, split);
run_ranch(pname, reps)
make_pools(split, n);

disp("Finished.")

