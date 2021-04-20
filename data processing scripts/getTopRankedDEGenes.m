filename = 'LumALumBPValue05DESorted.csv';

DEgenes = readtable('LumALumBDE.csv');
DEResults = readtable('LumA_lumB.csv');

top = find(DEResults.FDR<0.05);
topGenes = DEResults.Var1(top);

[tf, locs] = ismember(DEgenes.Properties.VariableNames,topGenes);
[~,p] = sort(locs(tf));
idx = find(tf);
idx = idx(p);

geneTable = DEgenes(:,[1,2,idx]);

writetable(geneTable,filename);
