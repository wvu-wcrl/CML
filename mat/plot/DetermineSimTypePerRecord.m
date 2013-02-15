function SimTypes = DetermineSimTypePerRecord(sim_param)

number_cases = length( sim_param );

SimTypes = zeros( 8, number_cases );

for case_number=1:number_cases
    if strcmp( sim_param(case_number).sim_type, 'capacity' )
        SimTypes(1,case_number) = 1; % capacity simulation
    elseif strcmp( sim_param(case_number).sim_type, 'exit' )
        SimTypes(2,case_number) = 1; % EXIT
    elseif strcmp( sim_param(case_number).sim_type, 'uncoded' )
        SimTypes(3,case_number) = 1; % uncoded modulation
    elseif strcmp( sim_param(case_number).sim_type, 'coded' )
        SimTypes(4,case_number) = 1; % coded modulation
    elseif( strcmpi( sim_param(case_number).sim_type, 'outage' ) || strcmpi( sim_param(case_number).sim_type, 'bloutage' ) )
        SimTypes(5,case_number) = 1; % outage probability
    elseif strcmp( sim_param(case_number).sim_type, 'throughput' )
        SimTypes(6,case_number) = 1; % throughput of hybrid-ARQ
    elseif strcmp( sim_param(case_number).sim_type, 'bwcapacity' )
        SimTypes(7,case_number) = 1; % capacity of FSK under BW constraint
    elseif strcmp( sim_param(case_number).sim_type, 'minSNRvsB' )
        SimTypes(8,case_number) = 1; % Min SNR as a function of B
    end
end

end