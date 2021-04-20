
datain = readtable('original_noControls.csv');
datain = table2cell(datain);

%1 header
sample_corr = zeros(length(datain(1, 2:end)),1);

for i=1:length(datain(1, 2:end))
    t = cell2mat(datain(2:end, i+1));
    tt = cell2mat(datain(2:end, 2:end));
    tt(:, i) = [];
    temp = corr( tt, t, 'type', 'Spearman');%
    sample_corr(i) = nanmean(temp);
end

plotScatterForData(sample_corr, 'Spearman Corr', 'Quantile', num2cell([1:length(sample_corr)]))
