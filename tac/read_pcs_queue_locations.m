function [iq rq oq] = read_pcs_queue_locations();



% get user
[status user] = system('whoami');


%remove trailing carriage return from username
user = user(1:end-1);
	   

% create path to task controller config file
TC_CFG = ['/home' '/' user '/' '.ctc_cfg'];


% input path
heading = '[paths]';                                                             
key = 'input';
out = util.fp(TC_CFG, heading, key);
iq = out{1}{1};


% output path
heading = '[paths]';
key = 'output';
out = util.fp(TC_CFG, heading, key);
oq = out{1}{1};


% running path
heading = '[paths]';
key = 'active';
out = util.fp(TC_CFG, heading, key);
rq = out{1}{1};


end
