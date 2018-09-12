function logwrite(entry)
%errorlog.txt will have to sit with other files unless directory is changed in this function.
errorlogID = fopen('errorlog.txt', 'a');
if errorlogID == -1
  error('Cannot open log file.');
end
fprintf(errorlogID, '%s: %s\n', datestr(now, 0), entry);
fclose(errorlogID);

end
				