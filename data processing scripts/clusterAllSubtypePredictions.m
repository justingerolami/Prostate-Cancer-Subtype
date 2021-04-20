%{
This script clusters all 5 - LumA, LumB, Basal, Her2, Norm to see if we can
relabel the Her2 and Norm.
%}

pam_data = readtable('pam50_expression.csv');
classes = readtable('pam_expression_pam50scores.txt');
calls = classes.Call;

lumaLocs = contains(calls, "Basal");
lumbLocs = contains(calls, "LumB");
basLocs = contains(calls, "Basal");
allLocs = lumaLocs | lumbLocs;

%pam_data(:,[false, ~allLocs']) = [];
%classes(~allLocs,:) = [];

pam_data{:,2:end} = replaceZeros(pam_data{:,2:end}, 'lowval');
pam_data{:,2:end} = logTransform(pam_data{:,2:end});
medians = median(pam_data{:,2:end},2);
pam_data{:,2:end} = pam_data{:,2:end} - medians;

%pam_data{:,2:end} = zscore(pam_data{:,2:end}, 0, 2);

label_response = classes.Call;

s2 = struct;
s2.Labels = label_response;
colorvec = cell(length(label_response), 1);
colorvec(strcmpi(label_response, 'LumA')) = {[0 1 0]}; %green
colorvec(strcmpi(label_response, 'LumB')) = {[1 0 0]}; %red
colorvec(strcmpi(label_response, 'Basal')) = {[0 0 1]}; %blue
colorvec(strcmpi(label_response, 'Normal')) = {[0.49 0.18 0.56]};
colorvec(strcmpi(label_response, 'Her2')) = {[0.93 0.69 0.13]};

s2.Colors = (colorvec);

cgo = clustergram(pam_data{:,2:end}, 'RowPDist', 'euclidean', 'ColumnPDist', 'euclidean',...
 'ColumnLabels', classes.Call,'RowLabels',...
 pam_data.Gene, 'ColorMap', myColourMap_RedBlue, 'DisplayRange', 7, 'LabelsWithMarkers',true);

set(cgo, 'ColumnLabelsColor',s2)
