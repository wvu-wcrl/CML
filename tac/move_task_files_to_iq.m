function move_task_files_to_iq(tmp_dir, iq)

cmd = ['mv ' tmp_dir '/' '*.mat' iq];
system(cmd);

end
