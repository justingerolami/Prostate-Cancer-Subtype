filename = 'LumBasal_Jan2021_Final.csv';
%load(strcat(filename,'.mat'));
data = readtable('filtered_low_immune_2021.csv','Format','auto');
classes = (data(1,2:end));
classes = table2cell(classes);
data(1,:) = [];

%set these to the 2 classes we want to compare
c1 = 'Lum';
c2 = 'Basal';

classes(contains(classes,'Lum')) = {'Lum'};

%remove the third class from the data
classLocs = contains(classes, c1) | contains(classes,c2);
classes(~classLocs) = [];

classes = ['Class', classes];

finalOutput = [celldata_ranked_cc(1,:);classes;celldata_ranked_cc(2:end,:)]';
finalOutput(1,1) = {'Sample'};
finalOutput = cell2table(finalOutput(2:end,:), 'VariableNames', strrep(finalOutput(1,:), '-', ''));
writetable(finalOutput, filename);