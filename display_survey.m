function linexy = display_survey(z, seeds_i, target_i, words, scale)

global W H white theWindow window_rect bgcolor bodymap barsize recsize rec 

% lb=W*7/128; %70
% tb=H*18/80; %180

% recsize=[W*450/1280 H*175/800];
% barsize=[W*340/1280, W*200/1280, W*340/1280, W*200/1280, W*340/1280, 0;
%         10, 10, 10, 10, 10, 0; 10, 0, 10, 0, 10, 0;
%         10, 10, 10, 10, 10, 0; 1, 2, 3, 4, 5, 0]; %��� ª����
% rec=[lb,tb; lb+recsize(1),tb; lb,tb+recsize(2); lb+recsize(1),tb+recsize(2); 
%     lb,tb+2*recsize(2); lb+recsize(1),tb+2*recsize(2)]; %6�� �簢���� ���� �� �������� ��ǥ 

title={'','������ ���õ� ����', '','������', '', '';
       '����', '���� ����', '����', '����', '����', '';
       '�߸�', '', '����', '', '�߸�', '';
       '����','�ſ� ����', '�̷�','�ſ�','����','';
       '�ܾ�� �������� ����', '�ܾ �ڽŰ� ������ �ִ� ����', '�ܾ ���� ������ �ִ� �ڽ��� �ð�', ...
       '�ܾ � ��Ȳ�̳� �����\n�󸶳� �����ϰ� ���ø��� �ϴ���', '�ܾ ���� �Ǵ� ������ \n�ǹ��ϰų� ������ �ϴ���', ''};

body_prompt = {'�ش� �ܾ ���ø� �� Ȱ��ȭ�Ǵ� ������ ��� �κ��� ����������,'
    '��Ȱ��ȭ�Ǵ� ������ ��� �κ��� �Ķ������� ��ĥ���ּ���.';
    '�� �ܾ ���ؼ� �������� �Ķ��� ��� ĥ�� �� �ֽ��ϴ�';
    '��ư r�� ������ ����������, b�� ������ �Ķ������� ĥ�� �� �ֽ��ϴ�.';
    '\n�� ĥ�ϼ����� Ű���� a�� �����ּ���.'};

% barsize = barsize(:,z);
title = title(:,z);

%% Coordinates for lines
linexy = zeros(2,48);

for i=1:6       % 6 lines
    linexy(1,2*i-1)= rec(i,1)+(recsize(1)-barsize(1,i))/2;
    linexy(1,2*i)= rec(i,1)+(recsize(1)+barsize(1,i))/2;
    linexy(2,2*i-1) = rec(i,2)+recsize(2)/2;
    linexy(2,2*i) = rec(i,2)+recsize(2)/2;
end

for i=1:6       % 3 scales for one line, 18 scales 
    linexy(1,6*(i+1)+1)= rec(i,1)+(recsize(1)-barsize(1,i))/2;
    linexy(1,6*(i+1)+2)= rec(i,1)+(recsize(1)-barsize(1,i))/2;
    linexy(1,6*(i+1)+3)= rec(i,1)+recsize(1)/2;
    linexy(1,6*(i+1)+4)= rec(i,1)+recsize(1)/2;
    linexy(1,6*(i+1)+5)= rec(i,1)+(recsize(1)+barsize(1,i))/2;
    linexy(1,6*(i+1)+6)= rec(i,1)+(recsize(1)+barsize(1,i))/2;
    linexy(2,6*(i+1)+1)= rec(i,2)+recsize(2)/2-barsize(2,i)/2;
    linexy(2,6*(i+1)+2)= rec(i,2)+recsize(2)/2+barsize(2,i)/2;
    linexy(2,6*(i+1)+3)= rec(i,2)+recsize(2)/2-barsize(3,i)/2;
    linexy(2,6*(i+1)+4)= rec(i,2)+recsize(2)/2+barsize(3,i)/2;
    linexy(2,6*(i+1)+5)= rec(i,2)+recsize(2)/2-barsize(4,i)/2;
    linexy(2,6*(i+1)+6)= rec(i,2)+recsize(2)/2+barsize(4,i)/2;
end

%% locations of the two words
interval = 100;
Screen('TextSize', theWindow, 30);
response_W(1) = Screen(theWindow, 'DrawText', double(words{target_i,seeds_i}), 0, 0);
response_W(2) = Screen(theWindow, 'DrawText', double(words{target_i+1,seeds_i}), 0, 0);

x(1) = W/2 - interval/2 - response_W(1) - response_W(2)/2;
x(2) = W/2 + interval/2 - response_W(2)/2;

fontsize = [30, 50, 22, 20]; % Word1, W2, title(1,:), title(2~4,:) 

%%
switch scale 
    case 'whole'
        Screen(theWindow, 'FillRect', bgcolor, window_rect);
        Screen('PutImage', theWindow, bodymap, window_rect); % put bodymap image on screen
        
        % Two words
        Screen('TextSize', theWindow, fontsize(1));
        DrawFormattedText(theWindow, double(words{target_i,seeds_i}), x(1), H/7, white, [], [], [], 1.5);      
        Screen('TextSize', theWindow, fontsize(2));
        DrawFormattedText(theWindow, double(words{target_i+1,seeds_i}), x(2), H/7, white, [], [], [], 1.5);
        % Draw scale lines
        Screen('DrawLines',theWindow, linexy, 3, 255);
        % Draw scale letter
        for i = 1:numel(title(1,:))
            Screen('TextSize', theWindow, fontsize(3));
            DrawFormattedText(theWindow, double(title{1,i}),'center', 'center', white, [],[],[],[],[],...
                [rec(i,1), rec(i,2)+5, rec(i,1)+recsize(1), rec(i,2)+recsize(2)/2]);
            Screen('TextSize', theWindow, fontsize(4));
            DrawFormattedText(theWindow, double(title{2,i}),'center', 'center', white, [],[],[],[],[],...
                [linexy(1,2*i-1)-15, linexy(2,2*i-1), linexy(1,2*i-1)+20, linexy(2,2*i-1)+60]);
            DrawFormattedText(theWindow, double(title{3,i}),'center', 'center', white, [],[],[],[],[],...
                [rec(i,1)+recsize(1)/3, linexy(2,2*i-1), rec(i,1)+recsize(1)*2/3, linexy(2,2*i-1)+60]);
            DrawFormattedText(theWindow, double(title{4,i}),'center', 'center', white, [],[],[],[],[],...
                [linexy(1,2*i)-20, linexy(2,2*i-1), linexy(1,2*i)+15, linexy(2,2*i-1)+60]);
        end
        
%     case 'button' % erase if not use
%         Screen(theWindow, 'FillRect', bgcolor, window_rect);
% %         Screen('PutImage', theWindow, bodymap); % put bodymap image on screen
%         Screen('TextSize', theWindow, 30);
%         DrawFormattedText(theWindow, double(words{target_i,seeds_i}), x(1), H/7, white, [], [], [], 1.5);      
%         Screen('TextSize', theWindow, 50);
%         DrawFormattedText(theWindow, double(words{target_i+1,seeds_i}), x(2), H/7, white, [], [], [], 1.5);
%         Screen('DrawLines',theWindow, linexy, 3, 255);
%         for i = 1:numel(title(1,:))
%             Screen('TextSize', theWindow, 22);
%             DrawFormattedText(theWindow, double(title{1,i}),'center', 'center', white, [],[],[],[],[],...
%                 [rec(i,1), rec(i,2)+5, rec(i,1)+recsize(1), rec(i,2)+recsize(2)/2]);
%             Screen('TextSize', theWindow, 18);
%             DrawFormattedText(theWindow, double(title{2,i}),'center', 'center', white, [],[],[],[],[],...
%                 [linexy(1,2*i-1)-15, linexy(2,2*i-1), linexy(1,2*i-1)+20, linexy(2,2*i-1)+60]);
%             DrawFormattedText(theWindow, double(title{3,i}),'center', 'center', white, [],[],[],[],[],...
%                 [rec(i,1)+recsize(1)/3, linexy(2,2*i-1), rec(i,1)+recsize(1)*2/3, linexy(2,2*i-1)+60]);
%             DrawFormattedText(theWindow, double(title{4,i}),'center', 'center', white, [],[],[],[],[],...
%                 [linexy(1,2*i)-20, linexy(2,2*i-1), linexy(1,2*i)+15, linexy(2,2*i-1)+60]);
%         end
% 
%     case 'body' % erase if not use
%         Screen(theWindow, 'FillRect', bgcolor, window_rect);
%         Screen('PutImage', theWindow, bodymap); % put bodymap image on screen
%         Screen('TextSize', theWindow, 30);
%         DrawFormattedText(theWindow, double(words{target_i,seeds_i}), x(1), H/7, white, [], [], [], 1.5);      
%         Screen('TextSize', theWindow, 50);
%         DrawFormattedText(theWindow, double(words{target_i+1,seeds_i}), x(2), H/7, white, [], [], [], 1.5);
    
    case 'practice1'
        Screen(theWindow, 'FillRect', bgcolor, window_rect);
        Screen('PutImage', theWindow, bodymap, window_rect); % put bodymap image on screen

        % Two words
        Screen('TextSize', theWindow, fontsize(1));
        DrawFormattedText(theWindow, double(words{target_i,seeds_i}), x(1), H/7, white, [], [], [], 1.5);      
        Screen('TextSize', theWindow, fontsize(2));
        DrawFormattedText(theWindow, double(words{target_i+1,seeds_i}), x(2), H/7, white, [], [], [], 1.5);
        % Draw scale lines
        Screen('DrawLines',theWindow, linexy, 3, 255);
        % scale letter
        for i = 1:numel(title(1,:))
            Screen('TextSize', theWindow, fontsize(4));
            DrawFormattedText(theWindow, double(title{2,i}),'center', 'center', white, [],[],[],[],[],...
                [linexy(1,2*i-1)-15, linexy(2,2*i-1), linexy(1,2*i-1)+20, linexy(2,2*i-1)+60]);
            DrawFormattedText(theWindow, double(title{3,i}),'center', 'center', white, [],[],[],[],[],...
                [rec(i,1)+recsize(1)/3, linexy(2,2*i-1), rec(i,1)+recsize(1)*2/3, linexy(2,2*i-1)+60]);
            DrawFormattedText(theWindow, double(title{4,i}),'center', 'center', white, [],[],[],[],[],...
                [linexy(1,2*i)-20, linexy(2,2*i-1), linexy(1,2*i)+15, linexy(2,2*i-1)+60]);
            DrawFormattedText(theWindow, double(title{5,i}),'center', 'center', white, [],[],[],[],[],...
                [rec(i,1), rec(i,2)+5, rec(i,1)+recsize(1), rec(i,2)+recsize(2)/2]);
        end
        
    case 'practice2'
        Screen(theWindow, 'FillRect', bgcolor, window_rect);
        Screen('PutImage', theWindow, bodymap, window_rect); % put bodymap image on screen
        
        % Two words
        Screen('TextSize', theWindow, 30);
        DrawFormattedText(theWindow, double(words{target_i,seeds_i}), x(1), H/7, white, [], [], [], 1.5);
        Screen('TextSize', theWindow, 50);
        DrawFormattedText(theWindow, double(words{target_i+1,seeds_i}), x(2), H/7, white, [], [], [], 1.5);
        Screen('TextSize', theWindow, 23);
        % Instruction
        for i = 1:numel(body_prompt)
            DrawFormattedText(theWindow, double(body_prompt{i}), 'center', 200+30*i, white);
        end
 
end
end