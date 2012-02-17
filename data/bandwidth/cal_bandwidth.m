function BwMatrix = cal_bandwidth(sim_M_vec, sim_h_vec, percent, precision, filename)

% some constants
infinity = 100000;
epsilon = 1e-4;
target_tail = (1-percent)*0.5;

% append .mat to filename, if necessary
if ~strcmpi( filename( (length(filename)-3):length(filename)), '.mat' )
    filename=[filename,'.mat'];
end

BwMatrix = zeros(0,3);
% read in the previously saved file
if ( fopen( filename ) > 0 )
    load( filename )                   
end

Mtotal = length( sim_M_vec );
htotal = length( sim_h_vec );

% update the BwMatrix with new entries
BwMatrixCount = size( BwMatrix, 1 );

for m_count=1:Mtotal
    for h_count=1:htotal           
        
        % see if this entry already exists in the database
        M_values = find( BwMatrix(:,1) == sim_M_vec( m_count ) );
        h_values = find( abs(BwMatrix(:,2) - sim_h_vec( h_count ) ) < epsilon);    
        Matching_row = min( intersect( M_values, h_values ) );
        
        if ( length( Matching_row ) )
            % row exists
            fprintf( 'An entry exists of M = %d and h = %f\n', sim_M_vec(m_count), sim_h_vec(h_count) );
        else
            % need to make a new row in the matrix
            BwMatrixCount = BwMatrixCount + 1;
            BwMatrix( BwMatrixCount, : ) = [ sim_M_vec( m_count ) sim_h_vec( h_count ) -1 ];            
        end
    end
end


% Sort the Matrix
maxM = max( BwMatrix(:,1) );

BwMatrixSorted = [];
for mu_count = 1:log2( maxM )
    M = 2^mu_count;
    M_values = find( BwMatrix(:,1) == M );
    TempMatrix = BwMatrix( M_values, : );
    [temp,sort_index] = sort( TempMatrix(:,2) );
    BwMatrixSorted = [BwMatrixSorted
        TempMatrix(sort_index,:) ];
end

BwMatrix = BwMatrixSorted;

% compute each entry
for ( BwMatrixCount = 1:length( BwMatrix ) )
    if ( BwMatrix( BwMatrixCount, 3 ) <= 0 )
        % entry has not been computed yet
        M = BwMatrix(BwMatrixCount,1);
        h = BwMatrix(BwMatrixCount,2);
        
        fprintf( 'Calculating M=%d and h=%f\n', M, h );
        
        if (h>0.99)
            % need logic to handle h as it approaches 1.
        else           
            % approximate the integral as a summation
            power = 0.5*specfun(0,M,h)*precision; % only take half the power at f=0
            PSDcounter = 1;
            while ( 2*power <= percent )
                f = precision*PSDcounter;
                power = power + specfun( f, M, h )*precision;
                PSDcounter = PSDcounter + 1;
            end
            BwMatrix(BwMatrixCount,3) = 2*(f-precision);
        end
        
        save( filename, 'BwMatrix' ); 
        
       
    end
end


