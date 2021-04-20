%{
This function simply median centers each of the PAM50 genes as required
by the PAM50 algorithm.
%}

%load the data
pam50_expression = readtable('data/pam50_expression.csv');

%find the median of each gene
medians = median(pam50_expression{:,2:end},2);

%subtract the median from the respective gene
pam50_expression{:,2:end} = pam50_expression{:,2:end} - medians;

%save the median centered data
writetable(pam50_expression, 'data/pam50_medianCentered.csv');