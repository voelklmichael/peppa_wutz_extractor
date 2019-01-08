function [changes] = peppa_convert(folder, file_input);
blue_background = nan(1,1,3);
blue_background(1) = 148;
blue_background(2) = 193;
blue_background(3) = 243;
%folder ='/home/michael/Downloads/peppa';
files = readdir(folder);
files = files(cellfun(@(x) length(x)>3 && strcmp(x(end-3:end), '.bmp'), files));
[~, perm] = sort(cellfun(@(x) str2double(x(1:end-4)), files));
files = files(perm);
deviations = false(1, length(files)-2);
deviation = nan(1,5);
for fileIndex = 2:length(files)-1;
  file = fullfile(folder, files{fileIndex});
  data_ = imread(file);
  data = double(data_);
  top = data(1, :, :);
  bottom = data(end-6:end, :, :);
  left = data(:, 1:10, :);
  right = data(:, end-10:end, :);
  deviation(1) = max(max(max(abs(top./blue_background-1))));
  deviation(2) = max(max(max(abs(bottom./blue_background-1))));
  deviation(3) = max(max(max(abs(left./blue_background-1))));
  deviation(4) = max(max(max(abs(right./blue_background-1))));
  deviation(5) = max(max(max(abs(data_./blue_background-1))));
  deviation_ = all(deviation(1:4)<0.2) & deviation(5)>0.2;
  deviations(fileIndex-1) = deviation_;  
end % for
clear file fileIndex data data_ top bottom left right deviation deviation_;
changes = find(~deviations(1:end-1) & deviations(2:end));
changes = changes(all(deviations(changes+[1:4]')));
changes = changes+2; % +1 for fileIndex offset, +1 to find first header instead of last movie
%%
close all;
[~, file_input] = fileparts(file_input);
file_input = strrep(file_input, '\ ', '_');
counter = 0;
for i = 1 : length(changes)
  counter += 1;
  figure;
  file = fullfile(folder, files{changes(i)});
  data_ = imread(file);
  image(data_);
  title([file ' - change ' num2str(i) ' @ ' num2str(changes(i))]);  
  print(fullfile('/media/michael/C4A62A22A62A1608/peppa_wutz/plots/', [file_input '_change_' num2str(counter) '.jpg']));
end % for

end
