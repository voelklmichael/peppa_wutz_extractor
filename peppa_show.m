close all; clear; clc
folder = '/media/michael/C4A62A22A62A1608/peppa_wutz/plots';
content = readdir(folder);
content = content(cellfun(@(x) length(x)>4 && strcmp(x(end-3:end), '.jpg'), content));
j = [493, 737, 1723, 2162, 2204, 2416];
c = content(j);
d = cellfun(@(x) strsplit(x, '_change_'), c, 'UniformOutput', 0);
d = cellfun(@(x) [x{1} '.mp4'], d, 'UniformOutput', 0);
cellfun(@(x) exist(fullfile(folder, x), 'file'), d)

%for i = 1 : length(j)
%  content{j(i)}
%  file = fullfile(folder, content{j(i)});
%  im = imread(file);
%  figure;
%  imshow(im);
%  title([num2str(i) ' of ' num2str(length(content))]);
%  pause(0.1);
%  if i>10
%  aeae
%  end
%end % for i


