function [pun_pattern, tail_pattern] = UmtsPunPattern( framesize, code_bits_per_frame )

N = 3*framesize+12;
X_i = N/3;

% This is the combined pun_pattern and tail_pattern
total_pattern = zeros(3,X_i);

% don't puncture the systematic part
total_pattern(1,:) = ones(1,X_i);

% set up parameters
delta_N = code_bits_per_frame - N; 
e_ini = X_i;

% puncture first parity stream
e_plus = 2*X_i;
e_minus = 2*abs( floor( delta_N/2 ) );
parity_1 = RateMatch( 1:X_i, X_i, e_ini, e_plus, e_minus );
total_pattern(2,parity_1) = ones( size(parity_1) );

% puncture second parity stream
e_plus = X_i;
e_minus = abs( ceil( delta_N/2 ) );
parity_2 = RateMatch( 1:X_i, X_i, e_ini, e_plus, e_minus );
total_pattern(3,parity_2) = ones( size(parity_2) );

% bit collection
pun_pattern(1,:) = ones(1,framesize);
pun_pattern(2,:) = total_pattern(2,1:framesize);
pun_pattern(3,:) = zeros(1,framesize);
pun_pattern(4,:) = total_pattern(3,1:framesize);

tail_pattern = reshape( total_pattern(:,framesize+1:X_i),4, 3 );




