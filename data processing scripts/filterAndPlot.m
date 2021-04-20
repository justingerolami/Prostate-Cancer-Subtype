function celldata_filt = filterAndPlot(filename, threshold, percnt)

%Load the file
data = readtable(filename);
%Generate the sample labels (ignore taxa labels)
sample_labels = data.Properties.VariableNames;
genes = data.Gene;

expressions = table2array(data(:,2:end));

%remove the low expressed data
mark2remove = markLowCounts(expressions, threshold, percnt);

celldata_filt = data;
celldata_filt(mark2remove, :) = [];
expressions(mark2remove,:) = [];
disp(size(celldata_filt));

dataTransform = logTransform(replaceZeros(expressions, 'lowval')); 
boxplot(dataTransform);

writetable(celldata_filt, 'data/filtered_low_immune.csv');
end
