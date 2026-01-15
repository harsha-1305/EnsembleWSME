thisFile = mfilename('fullpath');
thisDir  = fileparts(thisFile);

addpath(genpath(fullfile(thisDir, 'pipelines')))
addpath(genpath(fullfile(thisDir, '..', 'src')))
addpath(genpath(fullfile(thisDir, '..', 'data')))
addpath(genpath(fullfile(thisDir, '..', 'results')))