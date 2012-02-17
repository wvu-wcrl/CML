% File hFskAWGNBICMCapacity
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the Shannon capacity
% under modulation constraints.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'FskCapacity';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% few_trials = 5;
% many_trials = 30;
few_trials = 5;
many_trials = 11;
epsilon = 1e-4;

% list of values to simulate
% for naming convention, h should be no less than 0.01 apart
h = [0.01:0.01:1];
% h = 0.32;

M = [4 8];
,apping = { 'gray', 'natural' };

linetype = { 'g-', 'r-', 'b-', 'k-' };
linetype = circshift( linetype, [0 1] );

minEsNodB = -30;
maxEsNodB = 45;
spacing_coarse = 0.5;
spacing_fine = 0.1;

% What is the minimum BW we are interested in?
min_bandwidth_constraint = 0.5;

% get the BW information
load BW99percent

% this is the CM capacity in AWGN
record = 0;
for mcount=1:length(M)
    for lcount=1:length(mapping)
        for hcount=1:length(h)
        
            record = record + 1;

            sim_param(record).comment = sprintf( 'BICM capacity of %d-FSK w/ h=%1.2f and %s mapping in AWGN\n', M(mcount), h(hcount), mapping{lcount} );

            % particular to this record
            sim_param(record).h = h(hcount);
            sim_param(record).mod_order = M(mcount);

            % create the filename and see if it exists
            filename = strcat( 'BICM_', int2str( M(mcount) ), 'FSK_h' );

            if ( h(hcount) == 1)
                filename = strcat( filename, '1' );
            elseif (abs(h(hcount)-0.9) < epsilon )
                filename = strcat( filename, '09' );
            elseif (abs(h(hcount)-0.8) < epsilon )
                filename = strcat( filename, '08' );
            elseif (abs(h(hcount)-0.7) < epsilon )
                filename = strcat( filename, '07' );
            elseif (abs(h(hcount)-0.6) < epsilon )
                filename = strcat( filename, '06' );
            elseif (abs(h(hcount)-0.5) < epsilon )
                filename = strcat( filename, '05' );
            elseif (abs(h(hcount)-0.4) < epsilon )
                filename = strcat( filename, '04' );
            elseif (abs(h(hcount)-0.3) < epsilon )
                filename = strcat( filename, '03' );
            elseif (abs(h(hcount)-0.2) < epsilon )
                filename = strcat( filename, '02' );
            elseif (abs(h(hcount)-0.1) < epsilon )
                filename = strcat( filename, '01' );
            elseif ( h(hcount) < 0.1 )
                filename = strcat( filename, '00', int2str( 100*h(hcount) ) );
            else
                filename = strcat( filename, '0', int2str( 100*h(hcount) ) );
            end

            filename = strcat( filename, '_AWGN_CSI_' );
            filename = strcat( filename, mapping{lcount} );
            filename = strcat( filename, '.mat' );

            % see if the file already exists
            sim_param(record).filename = strcat( data_directory, filename );
            fprintf( strcat ( 'Attempting to open file ', filename, '\n' ));
            fid = fopen( sim_param(record).filename );
            if (  fid > 0 )
                fprintf( 'File exists\n\n' );

                % load
                load(sim_param(record).filename);
                fclose( fid );

                % determine the interesting range of SNR
                r = save_state.capacity_avg;
                rindex = find( r>epsilon & r< 1-epsilon);

                if (length(rindex)==0)
                    fprintf( 'rindex is empty\n' );
                    % create SNR
                    sim_param(record).SNR = minEsNodB:spacing_coarse:maxEsNodB;
                    sim_param(record).max_trials = few_trials*ones( 1, length( sim_param(record).SNR ) );
                else

                    % first determine min EsNo (for unconstrained bandwidth)
                    EsNo = 10.^(save_param.SNR(rindex)/10);
                    EbNo = EsNo./(r(rindex)*log2(save_param.mod_order));

                    [y,index] = min(EbNo);
                    ThisMinEsNodB = 10*log10(EsNo(index));

                    % then determine max EsNo (for constrained bandwidth)

                    % determine the minimum allowable code rate
                    M_values = find( BwMatrix(:,1) == save_param.mod_order );
                    h_values = find( abs(BwMatrix(:,2) - save_param.h) < epsilon);
                    Matching_row = min( intersect( M_values, h_values ) );
                    bandwidth = BwMatrix( Matching_row, 3 );

                    min_rate = bandwidth/log2(save_param.mod_order)/min_bandwidth_constraint;

                    ThisMaxEsNodB = NaN;
                    if (length(rindex) > 1 )
                        ThisMaxEsNodB = interp1( r(rindex), save_param.SNR(rindex), min_rate );
                    end

                    if ( isnan( ThisMaxEsNodB ) )
                        ThisMaxEsNodB = maxEsNodB;
                    end

                    fprintf( 'h=%1.2f min=%2.1f max=%2.1f\n', save_param.h, ThisMinEsNodB, ThisMaxEsNodB );
                    fprintf( '\n' );

                    coarse_spacings = (maxEsNodB-minEsNodB)/spacing_coarse + 1;
                    fine_spacings = spacing_coarse/spacing_fine;

                    % create SNR vector
                    EsNodB = minEsNodB;
                    index = 1;
                    for i=1:coarse_spacings
                        for j=1:fine_spacings
                            fine = (EsNodB >= ThisMinEsNodB - spacing_coarse )&(EsNodB <= ThisMaxEsNodB + spacing_coarse);
                            if (j==1)
                                sim_param(record).SNR(index) = EsNodB;
                                if ( fine )
                                    sim_param(record).max_trials(index) = many_trials;
                                else
                                    sim_param(record).max_trials(index) = few_trials;
                                end
                                index = index + 1;
                            elseif ( ( fine | sum( abs( save_param.SNR-EsNodB ) < epsilon ) )&(i<coarse_spacings) )
                                sim_param(record).SNR(index) = EsNodB;
                                sim_param(record).max_trials(index) = many_trials;
                                index = index + 1;
                            end

                            EsNodB = EsNodB + spacing_fine;
                        end
                    end
                end

            else
                % fprintf( 'File does not exist\n\n' );
                % create SNR
                sim_param(record).SNR = minEsNodB:spacing_coarse:maxEsNodB;
                sim_param(record).max_trials = few_trials*ones( 1, length( sim_param(record).SNR ) );
            end

            % generic to all records
            sim_param(record).sim_type = 'capacity';
            sim_param(record).SNR_type = 'Es/No in dB';
            sim_param(record).framesize = 10000;
            sim_param(record).modulation = 'FSK';
            sim_param(record).mapping = mapping{ lcount };
            sim_param(record).channel = 'AWGN';
            sim_param(record).csi_flag = 1; %noncoherent (w/ CSI)
            sim_param(record).bicm = 1;
            sim_param(record).demod_type = 0; % does not matter if not BICM
            sim_param(record).linetype = linetype{ mod(record,length(linetype) )+1};
            sim_param(record).legend = sim_param(record).comment;
            sim_param(record).reset = 0;
            sim_param(record).save_rate = 50;
        end
    end
end

