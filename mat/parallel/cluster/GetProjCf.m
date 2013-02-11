function cf_path = GetProjCf()    % get config file for this user

  user = get_current_user();

cml_proj_cf = 'cml_cfg';
cf_path = ['/home' '/' user '/' cml_proj_cf];
end
