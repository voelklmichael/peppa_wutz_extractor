function peppa_split(input);
confirm_recursive_rmdir(0);
[status,msg,id] = rmdir('/home/michael/Downloads/temp/', 's');
if status!=1
  disp(msg);
  aaa
end % if
[status, msg,id] = mkdir('/home/michael/Downloads/temp/');
if status!=1
  disp(msg);
  alb
end % if
clear msg id status;
output_folder = '/home/michael/Downloads/temp/';
%input = '/home/michael/Downloads/peppa/Peppa\ Wutz\ _\ Neue\ Sammlung\ 2017\ #1\ \ _\ Peppa\ Pig\ Deutsch\ Neue\ Folgen\ _\ Cartoons\ für\ Kinder.mp4';
command =  ['ffmpeg -i ' input ' -r 3 -s 80x60 ' output_folder '%04d.bmp 2> ' output_folder 'output.log'];
[a,b] = system(command);

end