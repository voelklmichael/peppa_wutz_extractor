clear; close all; clc;
%input = '/home/michael/Downloads/peppa/Peppa\ Wutz\ _\ Neue\ Sammlung\ 2017\ #1\ \ _\ Peppa\ Pig\ Deutsch\ Neue\ Folgen\ _\ Cartoons\ für\ Kinder.mp4';
output = '/media/michael/C4A62A22A62A1608/peppa_wutz/shortent';
inputs = '/media/michael/C4A62A22A62A1608/peppa_wutz/Uploads_from_Peppa_Pig_Deutsch';
files = readdir(inputs);
files = files(cellfun(@(x) length(x)>3 && strcmp(x(end-3:end), '.mp4'), files));
for file_index = 98 : length(files)
  disp(['---- ' num2str(file_index) ' of ' num2str(length(files))]);
  tic;
  file = files{file_index};
  file = strrep(file, ' ', '\ ');
  file = strrep(file, '(', '\(');
  file = strrep(file, ')', '\)');
  input = fullfile(inputs, file);
  %output = '/home/michael/Downloads/peppa/';
  peppa_split(input);
  [times, frames] = peppa_log('/home/michael/Downloads/temp/output.log');
  folder = '/home/michael/Downloads/temp/';
  file_input = file;
  changes = peppa_convert(folder, file_input);
  times = [0,times];
  frames = [0,frames];
  split_times = [0, interp1(frames, times, changes), times(end)];
  for split_time_index = 1 : length(split_times)-1
    b = split_times(split_time_index);
    e = split_times(split_time_index+1);
    t = num2str(ceil(e-b));
    b = num2str(floor(b));
    %%
    [~, filename, ~] = fileparts(input);
    filename = fullfile(output, [filename '___part_' num2str(split_time_index) '.mp3']);    
    command = ['ffmpeg -i ' input ' -ss ' b ' -t ' t ' -acodec libmp3lame -vn -ab 128k ' filename ' >/dev/null 2>&1'];
    [temp1,temp2] = unix(command);
  end % for split_time_index
  toc;
end % for file_index
