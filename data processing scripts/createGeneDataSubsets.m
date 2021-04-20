%{
This script loads in a list of 498 samples with all genes, the list of
the 50 PAM50 genes, and the list of immune genes

It saves a dataset of 498 patients with 50 genes and one with 923 immune
genes
%}

data = readtable('data/noOutliers_original_noControls.csv');
pam50 = readtable('data/gene_lists/PAM50_GeneList.csv');
immune = readtable('data/gene_lists/Immune_GeneList.csv');


%Find the genes in our big dataset
[~, pamLocs] = intersect(data.Gene, pam50.Gene);
[~, immuneLocs] = intersect(data.Gene, immune.Gene);

%get the pam50 and immune expression levels for all samples
pamcounts = data(pamLocs,:);
immunecounts = data(immuneLocs,:);

%save the new dataset
writetable(pamcounts, 'data/pam50_expression.csv');
writetable(immunecounts, 'data/immune_expression.csv');
