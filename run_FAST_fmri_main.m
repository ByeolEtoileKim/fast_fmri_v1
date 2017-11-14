
%% Sess 1
    %% Resting & Word Generation
    fast_fmri_resting(0.01,'test');       % practice resting
    % fast_fmri_resting(6);       % 6 min resting
    fast_fmri_word_generation(seeds_rand{1},'test');
    % fast_fmri_resting(2)        % 2 min resting

    %% Transcribe
    fast_fmri_transcribe_responses('nosound') % while running fast_fmri_word_generation
    fast_fmri_transcribe_responses('only_na') % after running fast_fmri_word_generation

    %% Thinking and Rating
    ts = fast_fmri_generate_ts;
    fast_fmri_task_main(ts,'practice', 'test');
    fast_fmri_task_main(ts,'test');

    %% Whole words list & Survey
    words = fast_fmri_wholewords;
    fast_fmri_survey(words);

    %%


%% RUN ONCE for the experiment
seeds = {'�д�', '����', '�ſ�', '����', '����Ʈ', '���'};
% seeds = {'����', '������', '����', 'ȯ��', '����', '����'};
seeds_rand = seeds(randperm(numel(seeds)));