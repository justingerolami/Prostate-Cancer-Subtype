%{
Script removes the outliers based on the 'sample_corr' value from
computeSampleCorr.m and manually selecting the cutoff
%}

data = readtable('original_noControls.csv');

cutoff = 0.9174;

%find the outliers
outlierLocs = sample_corr<0.9174;

%remove from dataset
data(:,[false outlierLocs']) = [];

writetable(data, 'data/noOutliers_original_noControls.csv');
