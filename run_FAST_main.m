%% run task
% seeds = {'����', '������', '����', '�ƺ�', '����', '�Ѽ�', '�ǹ�'};

seeds = {'����'};
fast_task_main(seeds,  'repeat', 5);

%% transcription
transcribe_responses;

%% survey

fast_survey_main('scriptdir', 'C:\Users\Cocoan Lab WD02\Documents\Experiments\fast_task-master');