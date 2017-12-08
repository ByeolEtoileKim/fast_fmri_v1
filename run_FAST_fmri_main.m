
%% LAPTOP1 - Resting & Word Generation ====================================
    fast_fmri_resting(0.01,'test');       % practice resting
    
    %% first time
    fast_fmri_word_generation('','practice');   % recording test
    fast_fmri_resting(6, 'biopac','eye');       % 6 min resting

        %% WORD GENERATION + 2m RESTING
        fast_fmri_word_generation(seeds_rand,'biopac','eye');
        
        %% THINKING AND RATING
        [ts, isi_iti] = fast_fmri_generate_ts;
        fast_fmri_task_main(ts, isi_iti,'biopac','eye');

    
   
%% LAPTOP2 - Transcribe ===================================================
    fast_fmri_transcribe_responses('nosound') % while running fast_fmri_word_generation
    
    %%    
    fast_fmri_transcribe_responses('only_na') % after running fast_fmri_word_generation
    
    %%
    fast_fmri_transcribe_responses('response_n', [2 38]) % playing sound only a few specific trials
    
            %% if you want to revise already written items.
            savedir = fullfile(pwd, 'data');            
            SID = input('Subject ID (number)? ', 's');
            SessID = input('Session number? ', 's');  
            N = input('������ ��?    ','s');
            content = input('������ ����?    ','s');
           
            dat_file = fullfile(savedir, ['b_responsedata_sub' SID '_sess' SessID '.mat']);          
            load(dat_file);

            response{str2double(N),1} = content;
            save(fullfile(savedir, ['b_responsedata_sub' SID '_sess' SessID '.mat']),'response');
            
            
            
%% SURVEY 
    words = fast_fmri_wholewords;
%     fast_fmri_survey(words,'test');    
    fast_fmri_survey(words);


   


%% RUN ONCE for the experiment
seeds = {'�д�', '�ſ�', '����','����'};
% seeds = {'����', '����', 'ȯ��','���'};
seeds_rand = seeds(randperm(numel(seeds)));
% seeds_rand = {'�д�', '����', '�ſ�', '����'};   % when Matlab had to restart