
%% Sess 1
    %% Resting & Word Generation
    fast_fmri_resting(0.01,'test');       % practice resting
    
    fast_fmri_resting(6, 'biopac','eye');       % 6 min resting
    fast_fmri_word_generation('','practice');
    fast_fmri_word_generation(seeds_rand{1},'biopac','eye');
    fast_fmri_resting(2, 'biopac','eye')        % 2 min resting

    %% Transcribe
    fast_fmri_transcribe_responses('nosound') % while running fast_fmri_word_generation
    fast_fmri_transcribe_responses('only_na') % after runnin g fast_fmri_word_generation
    
    % if you want to revise already written items.
    response{#,1} = '�ϳ�';
    save(fullfile(fullfile(pwd, 'data'), ['b_responsedata_sub#_sess#.mat']),'response')
    
    %% Thinking and Rating
    [ts, isi_iti] = fast_fmri_generate_ts;
    
    fast_fmri_task_main(ts, isi_iti,'biopac','eye');

    %% Whole words list & Survey
    words = fast_fmri_wholewords;
    fast_fmri_survey(words,'test');

   


%% RUN ONCE for the experiment
seeds = {'�д�', '����', '�ſ�', '����', '����Ʈ', '���'};
% seeds = {'����', '������', '����', 'ȯ��', '����', '����'};
seeds_rand = seeds(randperm(numel(seeds)));