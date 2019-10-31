
script_fpath = mfilename('fullpath');
[script_dir, ~, ~ ] = fileparts(script_fpath);

subj73_mat = load([ script_dir '/stim_stm_color_event_73.mat' ]);
subj73_mat = subj73_mat.expr_events;

subj74_mat = load([ script_dir '/stim_stm_color_event_74.mat' ]);
subj74_mat = subj74_mat.expr_events;



% merge subj, condition, error into long format

merged_subj = [ [subj73_mat.subject]' ; [subj74_mat.subject]' ];
merged_cond = [ [subj73_mat.Stimulation]' ; [subj74_mat.Stimulation]' ];
merged_error = [ [subj73_mat.Error]' ; [subj74_mat.Error]' ];


% return error to 180 deg scale

merged_error = merged_error .* 2 ;

% relabel subjects with an index

unique_subj = unique(merged_subj);
unique_subj_table = table( (1:length(unique_subj))', unique_subj, 'VariableNames', {'index' 'subj'});


subj_index = [];

for iObs = 1:size(merged_subj)
    subj_index = [ subj_index ; find(merged_subj(iObs) == unique_subj)];
end


obs_table = table(merged_subj, subj_index, merged_cond, merged_error, 'VariableNames', {'subj' 'subj_index' 'stimulation' 'error'});

writetable(obs_table, [script_dir '/stimulation_obvs.csv' ]);