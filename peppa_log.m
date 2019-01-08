function [times, frames] = peppa_log(path)
content = fileread(path);
phrase = 'Press [q] to stop, [?] for help';
content = strrep(content, char(13), ' ');
content = strrep(content, char(10), ' ');
content = content(strfind(content, phrase):end);
content = strsplit(content, 'frame=');
content(1)=[];
content = cellfun(@(x) strsplit(x, {'fps=', 'time=', 'bitrate='}), content, 'UniformOutput', false);
frames = cellfun(@(x) str2double(x{1}), content);
times = cellfun(@(x) str2double(strsplit(x{3}, {'.', ':'})), content, 'UniformOutput', false);
times = (cell2mat(times')*[60*60; 60; 1; 1/100])';
end