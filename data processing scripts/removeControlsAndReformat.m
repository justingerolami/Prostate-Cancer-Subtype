%{
This is a script that removes all controls from the original.txt database. 
A control is a sample that contains -11A- or 06A in its name

Next, reformat the first column that contains the gene names
%}

%read the data
dataset = readtable('nonnorm_original.txt');

%find all columns that contain metastatic (06) and solid tissue normal (11)
sampleIDs = dataset.Properties.VariableNames;
controlLocs11A = contains(sampleIDs, "11A");
controlLocs11B = contains(sampleIDs, "11B");
controlLocs06A = contains(sampleIDs, "06A");
controlLocs06B = contains(sampleIDs, "06B");

allLocs = controlLocs11A | controlLocs11B | controlLocs06A | controlLocs06B;

%remove the controls
dataset(:, allLocs) = [];

%remove the first row which contains 'gene, normalized, normalized...'
dataset(1,:) = [];
dataset.Properties.VariableNames(1) = {'Gene'};

%Remove the stuff after the |
dataset.Gene = regexprep(dataset.Gene, '\|+[0-9]*', '');

%save the new dataset
writetable(dataset, 'data/nonnorm_original_noControls.csv');