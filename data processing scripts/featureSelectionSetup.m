%{
This code will setup the data and call the feature selection alg
%}

%load all data
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
data(:,[false,~classLocs]) = [];

data = [data.Properties.VariableNames;table2cell(data)];

rawd = data(2:end,2:end);
sn = data(1,:);
genes = data(:,1);

rawd = num2cell(round(str2double(rawd),3));
finaldata = [sn;genes(2:end) rawd];


%this code takes the data and classname and runs feature selection
[ranked_features_cc, celldata_ranked_cc] = runFeatureSelect_v3(finaldata, classes', 'kfold',5, true);

savename = strcat(c1,c2,'.mat');
save(savename,'ranked_features_cc', 'celldata_ranked_cc');
