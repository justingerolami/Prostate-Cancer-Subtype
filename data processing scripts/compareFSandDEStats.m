fs = readtable('LumALumB_FSStats.csv');
de = readtable('DEStats/lumA_lumB.csv');
dec = readtable('lumA_lumB_decision.csv');
dec.Properties.VariableNames(2) = {'decision'};
fs(:,3:15) = [];

%Intersect and add pvalue stats
[C,ia,ib] = intersect(fs.Gene,de.Var1, 'stable');
joinedTable = fs;
joinedTable.DERank = ib;
joinedTable = [joinedTable,de(ib,:)];
joinedTable(:,10:12) = [];

%intersect and add de call
[C,ia,ib] = intersect(joinedTable.Gene,dec.Var1, 'stable');
joinedTable.DE = dec.decision(ib);

writetable(joinedTable, 'FS_DE_Tables/LumALumB_FS_DE_Stats.csv');