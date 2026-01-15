# EnsembleWSME

This is a collection of MATLAB scripts that enables you to convert your pepval.mat to 3D structural ensembles.

## Installation Instructions

Following version of softwares are required -
- MATLAB v24.2.0.2773142 (R2024b) Update 2
    - Bioinformatics Toolbox
    - Optimization Toolbox
    - Parallel Computing Toolbox
    - Signal Processing Toolbox
    - Statistics and Machine Learning Toolbox
- ATSAS v4.1.0

On downloading the repo, navigate to inside the `scripts\` folder in MATLAB. **This should be the working directory in MATLAB.** Run `init.m` once, this generates missing the missing directories `data\` and `results\`.

## Overview of the repository -

Following is the structure of the repository once `init.m` has been run -
- `data\` - Should contain all the input files for the scripts
- `examples\` - Example input files for visualization (NHP6Am) and SAXS fitting (TipASm)
- `results\` - Where the generated structures are stored
- `src\` - Contains all the scripts not to be modified (unless you know what you're doing)
- `scripts\` - Entry point for the user. Scripts here can be tweaked to requirement. It is recommended to not edit any scripts in `scripts\pipelines` (except `vis_crysol.m` for formatting output graphs).

Currently, two major functionalities (or modes) are supported -
- Mode 1 : Visualization (example in `main_vis.m`) - Generating pools of structures
- Mode 2 : SAXS fitting (example in `main_saxs.m`) - Generating structures to fit experimental SAXS data

## Example 1 : Visualizing ensemble of NHP6A

1. Copy all 4 files from `examples\6Am` into `data\`. In general, assuming the protein is named `pname`, the following 4 files must be present for any visualization pipeline -

    1. `pname.cif` - The `.cif` native structure of the protein
    2. `pname.pdb` - The `.pdb` native structure of the protein
    3. `pname_BlockDet.dat` - Reference file for converting structured blocks to residues
    4. `pname_pepval.mat` - Microstate stability information

    Note that the files are named exactly as above, with `pname` being replaced for the name of your protein.

2. Open `scripts\main_vis.m`. Modify the following variables -

    1. `pname` - Set this to the name of your protein as in the files' names as above.
    2. `split` - Define the ends of the pools to consider. In the example, 4 pools are considered.
    3. `n` - The number of microstates to be considered in each pool (Default : 5).
    4. `reps` - The number of conformers to be generated per microstate (Default : 1).

    Note that to help determine split, you can run `disp_blocks(pname)` from the command line to visualise no. of structured blocks vs Delta G.

3. Run `main_vis.m`. A lot of warnings will come up as directories and files are overwritten, but it should be fine.

4. The structures will be output in `results\pools` in folders as `pool_1`, `pool_2`, ... The microstates' information in each pool is grouped into the variables `pool_1.mat`, `pool_2.mat`, ... for further reference. The structures can then be analyzed and modified in PyMol, VMD, etc.

## Example 2 : Predicting SAXS profile of TipASm

1. Copy all 5 files from `examples\TipASm` into `data\`. In general, assuming the protein is named `pname`, the following 4 files must be present for any visualization pipeline -

    1. `pname.cif` - The `.cif` native structure of the protein
    2. `pname.pdb` - The `.pdb` native structure of the protein
    3. `pname_BlockDet.dat` - Reference file for converting structured blocks to residues
    4. `pname_pepval.mat` - Microstate stability information
    5. `pname_SAXS.dat` - Experimental SAXS data

    Note that the files are named exactly as above, with `pname` being replaced for the name of your protein.

2. Open `scripts\main_saxs.m`. Modify the following variables -

    1. `pname` - Set this to the name of your protein as in the files' names as above.
    3. `n` - The number of top microstates to be considered as representative of the ensemble (Default : 100).
    4. `reps` - The number of conformers to be generated per microstate (Default : 30).

    Note that to the validity of `n` is manually verified at a later step. The value of `reps` is recommended to be between 20-50, as increasing it further does not offer significant increase in accuracy of prediction of SAXS profiles.

3. Open `scripts\pipelines\vis_crysol.m`. Verify the following (can skip this step if using example files only) -

    1. In lines `26, 27, 28`, the variables `x_exp, y_exp, y_err` are extracting the correct columns for scattering vector, intensity and error respectively. This would change depending on the format of the input file for the experimental SAXS data.
    2. In line `29`, the variable `c` controls how many data points to consider. This is useful to match the experimental and predicted ranges of scattering vectors for fitting.
    3. Note that the function `clean_x_y()` present in `src\` and called in line `34` is responsible for linear interpolation and scaling of predicted to experimental data. This can be manually tweaked or turned off, if required.
    4. Plotting is controlled between lines `36-48`. This can be changed as required.

4. Run `main_vis.m`. Prior to generation of structures, the script calculates how much of the ensemble is represented by the top `n` structures, and the percentage is displayed. The user is prompted to confirm before proceding (Type `Y` and press ENTER when asked). Let `n` be just high enough that around `90-95%` of the ensemble is represented. Further increase in `n` leads to minimal changes. During execution, a lot of warnings will come up as directories and files are overwritten, but it should be fine.

5. The structures will be output in `results\microstates`. Note that the final predicted SAXS profiles and the graphs are not by default saved locally; the can be manually saved if required (the final predicted SAXS values are stored in the variable `y`).
