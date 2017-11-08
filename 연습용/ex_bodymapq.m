% global theWindow W H; % window property
% global white red orange blue bgcolor response_W; % color
% global fontsize window_rect lb rb tb bb anchor_xl anchor_xr anchor_yu anchor_yd scale_H; % rating scale

bgcolor = 100;

window_rect = [1 1 1280 800]; % in the test mode, use a little smaller screen

W = window_rect(3); %width of screen
H = window_rect(4); %height of screen
textH = H/2.3;

font = 'NanumBarunGothic';
fontsize = 30;

white = 255;
red = [189 0 38];
blue = [0 85 169];
orange = [255 164 0];
red_trans = [189 0 38 80];
blue_trans = [0 85 169 80];

% rating scale left and right bounds 1/3 and 2/3
lb = 1.5*W/5; % in 1280, it's 384
rb = 3.5*W/5; % in 1280, it's 896 rb-lb = 512

% rating scale upper and bottom bounds 1/4 and 3/4
tb = H/5+100;           % in 800, it's 210
bb = H/2+100;           % in 800, it's 450, bb-tb = 240
scale_H = (bb-tb).*0.15;

anchor_xl = lb-80; % 284
anchor_xr = rb+20; % 916
anchor_yu = tb-40; % 170
anchor_yd = bb+20; % 710

bodymap = imread('imgs/bodymap_bgcolor.jpg');
bodymap = bodymap(:,:,1);
[body_y, body_x] = find(bodymap(:,:,1) == 255);

bodymap([1:10 791:800], :) = [];
bodymap(:, [1:10 1271:1280]) = []; % make the picture smaller
%% PROMPT SETUP:
ready_prompt{1}{1} = double('������ �־����� ������ �����ϰ� ������ּ���.');
ready_prompt{1}{2} = double('�� �ܾ�� ����Ǿ� �ִ� �ƶ��� ����ؼ� ������ֽø� �˴ϴ�.');
ready_prompt{1}{3} = double('�غ�Ǽ����� �����̽��ٸ� �����ּ���.');
ready_prompt2 = double('������ �־����� ������ �����ϰ� ������ּ���.\n�� �ܾ�� ����Ǿ� �ִ� �ƶ��� ����ؼ� ������ֽø� �˴ϴ�.\n�غ�Ǽ����� �����̽��ٸ� �����ּ���.');

question_prompt{1}{1} = double('������: �ܾ�� �������� ���� (����-����)');
question_prompt{1}{2} = double('������: ������ ���ü� (���þ���-���ø���)');
question_prompt{2}{1} = double('�� �ܾ�� �ð������� ����-����-�̷��� �࿡�� ����� ��ġ�ұ��?');
question_prompt{3}{1} = double('�� �ܾ ������ ��, Ȱ���� ''����''(����:r)�ǰų� ''����''(�Ķ�:b)�Ǵ� ���� ������ ����ΰ���?');
question_prompt{3}{2} = double('Ŭ���� ä�� �����̸� ��ĥ�� �˴ϴ�. ��ĥ�� ������ n�� �����ּ���.');

run_end_prompt = double('���ϼ̽��ϴ�. ���� �ܾ� ��Ʈ�� ��ٷ��ּ���.');
exp_end_prompt = double('������ ��ġ�̽��ϴ�. �����մϴ�!');

theWindow = Screen('OpenWindow', 0, bgcolor, window_rect); % start the screen
Screen('Preference','TextEncodingLocale','ko_KR.UTF-8');
Screen('TextFont', theWindow, font);
Screen('TextSize', theWindow, fontsize);

HideCursor;
for i = 1:numel(response) % the number of seed words
    for j = 1:numel(response{i}) % the number of generated words from a seed word
        response_W{i}{j} = Screen(theWindow, 'DrawText', double(response{i}{j}), 0, 0);
    end
end

seeds_i = 1;
target_i = 3;

%% THIRD question: body map - activate and deactivate
SetMouse(W/2, H/2); % set mouse at the center

start_t = GetSecs;

% default
z = randperm(2);
if z(1)==1
    color = red;
    color_code = 1;
else
    color = blue;
    color_code = 2;
end

while(1)

    % draw scale:
    Screen(theWindow, 'FillRect', bgcolor, window_rect); % reset
    Screen('PutImage', theWindow, bodymap); % put bodymap image on screen
    
    % display target word and previous words
    display_target_word(seeds_i, target_i, response);
    

    % Track Mouse coordinate
    [x, y, button] = GetMouse(theWindow);
    [~,~,keyCode] = KbCheck;
    
    if keyCode(KbName('r'))==1
        color = red;
        color_code = 1;
        keyCode(KbName('r')) = 0;
    elseif keyCode(KbName('b'))==1
        color = blue;
        color_code = 2;
        keyCode(KbName('b')) = 0;
    end
    
    % current location
    Screen('DrawDots', theWindow, [x;y], 5, color, [0 0], 1);
    Screen('Flip', theWindow);
    
end 


%%
KbWait;
Screen('CloseAll');

%%
function display_target_word(seeds_i, target_i, response)

global orange theWindow response_W W;

interval = 80;
y_loc = 80;

% ==== DISPLAY 2-3 RESPONSE WORDS ====

% 1. target word
target_loc = W/2 + interval/2;
Screen('TextSize', theWindow, 40); % present word, fontsize = 40
DrawFormattedText(theWindow, double(response{seeds_i}{target_i}), target_loc, y_loc, orange, [], [], [], 1.5);

% 2. Previous word
if target_i > 1
    pre_target_loc = W/2 - interval/2 - response_W{seeds_i}{target_i-1};
    Screen('TextSize', theWindow, 25); % previous word, fontsize = 25
    DrawFormattedText(theWindow, double(response{seeds_i}{target_i-1}), pre_target_loc, y_loc, 180, [], [], [], 1.5);
end


end