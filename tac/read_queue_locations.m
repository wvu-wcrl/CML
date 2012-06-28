function [iq rq oq] = read_pcs_queue_locations();



% get user
[status user] = system('whoami');


% create path to task controller config file
TC_CFG = ['/home' '/' user '/' '.ctc_cfg'];



% input path                                                                                                                                         heading = '[paths]';                                                                                                                                
key = 'input_queue';
out = util.fp(TC_CFG, heading, key);
iq = out{1};


% output path
heading = '[paths]';
key = 'output_queue';
out = util.fp(TC_CFG, heading, key);
oq = out{1};


% running path
heading = '[paths]';
key = 'run_queue';
out = util.fp(TC_CFG, heading, key);
rq = out{1};


end
