function cca_example_1()
%% Constants: configuration
% dataInFN = '../example_data/taste_a_paper_1.mat';
% dataInFN = '../example_data/taste_a_paper_2.mat';
dataInFN = '../example_data/taste_a_paper_3.mat';

ost_fn = 'ost_1';
% pcf_fn = 'f1_up.pcf';
% pcf_fn = 'f1_down.pcf';
% pcf_fn = 'f2_up.pcf';
pcf_fn = 'f1_up_f2_down.pcf';

%% Check that the path to Audapter exists
tpath = which('Audapter');
if isempty(tpath)
    error('Path to Audapter not set');
end

%% Load example data
load(dataInFN);

%% 
fs = data.params.sr;
data.params.bShift = 1;

sigIn = data.signalIn;

sigIn = resample(sigIn, 48000, fs);
sigInCell = makecell(sigIn, 96);

Audapter(6);   % Reset;

AudapterIO('init', data.params);

%% 
% Set OST (online sentence tracking) parameters
check_file(ost_fn);
Audapter(8, ost_fn, 1);

% Set PCF (perturbation configuration) parameters
check_file(pcf_fn);
Audapter(9, pcf_fn, 1);

%%
for n = 1 : length(sigInCell)
    Audapter(5, sigInCell{n});
end

data1 = AudapterIO('getData');

%% Visualization
% Input signal 
figure('Position', [50, 100, 1200, 700], 'Name', mfilename);
subplot('Position', [0.1, 0.5, 0.85, 0.45]);
show_spectrogram(data1.signalIn, data1.params.sr, 'noFig');
frameDur = data1.params.frameLen / data1.params.sr;
tAxis = 0 : frameDur : frameDur * (size(data1.rms, 1) - 1);
plot(tAxis, data1.ost_stat * 250, 'w-', 'LineWidth', 1.5);

plot(tAxis, data1.fmts(:, 1 : 2), 'c-');

plot(tAxis, data1.rms(:, 1) * 2e4, 'g-');

% Output signal (perturbed AF)
subplot('Position', [0.1, 0.05, 0.85, 0.45]);
show_spectrogram(data1.signalOut, data1.params.sr, 'noFig');
plot(tAxis, data1.fmts(:, 1 : 2), 'c-');
plot(tAxis, data1.sfmts(:, 1 : 2), 'w-');

drawnow;

%% Play sound
soundsc(data1.signalIn, data1.params.sr);
soundsc(data1.signalOut, data1.params.sr);
return