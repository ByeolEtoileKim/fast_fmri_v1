%% run task
% seeds = {'����', '������', '����', '�ƺ�', '����', '�Ѽ�', '�ǹ�'};

seeds = {'����'};
fast_task_main(seeds,'repeat',3,'test');

%% transcription
transcribe_responses;

%% survey

fast_survey_main('test');