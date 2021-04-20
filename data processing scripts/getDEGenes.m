filename = 'data/DEResults/lum_basal_DEGenes.csv';
DEResults = readtable('lumAB_basal_decision.csv');
DEResults(DEResults.Lum_Basal == 0,:) = [];
genesToKeep = DEResults.Var1';
genesToKeep = strrep(genesToKeep, '-', '');

filtGenes = readtable('data/finalData/LumBasal.csv');
genes = filtGenes.Properties.VariableNames(3:end);

[C, ia, locsToKeep] = intersect(genesToKeep,genes, 'stable');
locsToKeep = locsToKeep+2;

geneTable = filtGenes(:, [1;2;locsToKeep]);
writetable(geneTable,filename);

