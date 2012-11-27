function [user remote_cmlroot remote_projroot] = ...
    CmlReadClusterCfg(cml_home)

%platform
cfp = strcat(cml_home, '/cfg/cluster');

heading = '[cfg]';
key = 'USER';
out = util.fp(cfp, heading, key);
user = out{1}{1};

key = 'REMOTE_CMLROOT';
out = util.fp(cfp, heading, key);
remote_cmlroot = out{1}{1};

key = 'REMOTE_PROJROOT';
out = util.fp(cfp, heading, key);
remote_projroot = out{1}{1};

end
