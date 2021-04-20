%{
This script removes samples from our dataset and class file if the
predicted confidence is less than 0.75

%}

data = readtable('immune_expression.csv');
class = readtable('pam_scores.txt');
pam50 = readtable('pam50_expression.csv');

%Create our new table
SampleID = class.Var1;
Call = class.Call;
Confidence = str2double(class.Confidence);
class = table(SampleID,Call,Confidence);

%Remove low confidence from class file
class(class.Confidence < 0.75, :) = [];

%find out which samples we have left
SampleID = class.SampleID;

[~,ia] = setdiff(data.Properties.VariableNames(2:end), SampleID);
ia=ia+1;
data(:,ia) = [];


[~,ia] = setdiff(pam50.Properties.VariableNames(2:end), SampleID);
ia=ia+1;
pam50(:,ia) = [];


writetable(data, 'data/final_immune.csv');
writetable(class, 'data/class.csv');
writetable(pam50, 'data/final_pam50.csv');