clinical = readtable('PRAD.clin.merged.txt');
genes = readtable('filtered_low_immune.csv');

sampleNames = clinical(strcmp(clinical.Var1,'patient.bcr_patient_barcode'),2:end);

sampleNames = table2cell(sampleNames);
sampleNames = strrep(sampleNames, '.', '_');
sampleNames = strrep(sampleNames, '-', '_');

clinical.Properties.VariableNames(2:end) = sampleNames;
clinical.Properties.VariableNames(1) = {'Type'};

geneVarNames = genes.Properties.VariableNames(2:end);
geneVarNames = regexprep(geneVarNames, '_01A.*', '');
geneVarNames = regexprep(geneVarNames, '_01B.*', '');
geneVarNames = lower(geneVarNames);
%genes.Properties.VariableNames(2:end) = lower(geneVarNames);


sameSamples = ismember(lower(clinical.Properties.VariableNames(2:end)), geneVarNames);
sum(sameSamples)
clinical = clinical(:,[true,sameSamples]);
writetable(clinical, 'clinical_allFeatures.csv');

featuresToKeep = {
'age_at_initial_pathologic_diagnosis',
'biochemical_recurrence',
'bone_scan_results (in other words mets)',
'days_to_first_biochemical_recurrence',
'days_to_last_followup',
'drugs.drug-2.therapy_types.therapy_type',
'ethnicity',
'follow_ups.follow_up-2.days_to_first_biochemical_recurrence',
'follow_ups.follow_up-2.days_to_last_followup',
'follow_ups.follow_up.days_to_death',
'follow_ups.follow_up.days_to_first_biochemical_recurrence',
'follow_ups.follow_up.days_to_last_followup',
'follow_ups.follow_up.radiation_therapy',
'histological_type',
'history_of_neoadjuvant_treatment',
'laterality',
'radiation_therapy',
'stage_event.clinical_stage',
'stage_event.gleason_grading.gleason_score',
'stage_event.gleason_grading.primary_pattern',
'stage_event.gleason_grading.secondary_pattern',
'stage_event.gleason_grading.tertiary_pattern',
'stage_event.igcccg_stage',
'stage_event.pathologic_stage',
'stage_event.psa.days_to_psa',
'stage_event.psa.psa_value',
'stage_event.tnm_categories.pathologic_categories.pathologic_t',
'year_of_form_completion',
'year_of_initial_pathologic_diagnosis'};


clinical.Type = strrep(clinical.Type, 'patient.', '');
clinical.Type = strrep(clinical.Type, 'admin.', '');

featuresToKeepLocs = ismember(clinical.Type,featuresToKeep);
clinical = clinical(featuresToKeepLocs,:);
writetable(clinical, 'clinical_selectedFeatures.csv');


freq = zeros(height(clinical),1);
toRem = zeros(height(clinical),1);

for i=1:height(clinical)
    counter = sum(count(table2array(clinical(i,2:end)), 'NA'));
    if counter == width(clinical)-1
        toRem(i) = 1;
    end
end

filtClin = clinical;
filtClin(logical(toRem),:) = [];
writetable(filtClin, 'clinical_SelectedFeatures_FilteredNA.csv');


toRem = zeros(height(clinical),1);
for i=1:height(clinical)
    counter = sum(count(table2array(clinical(i,2:end)), 'NA'));
    if counter >= 0.5*width(clinical)-1
        toRem(i) = 1;
    end
end

filtClin = clinical;
filtClin(logical(toRem),:) = [];
writetable(filtClin, 'clinical_SelectedFeatures_Filtered_LT50%.csv');
