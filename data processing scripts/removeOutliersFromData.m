[~,~,rawgenes] = xlsread('genes_outlier.xlsx');
[~,~,rawclass] = xlsread('unclassified.xlsx');


[~, locs] = setdiff(rawclass(2:end,1), rawgenes(1,2:end));
locs = locs + 1;
rawclass(locs,:) = [];

xlswrite('filt_unclassified.xlsx', rawclass);