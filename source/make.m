% makefile for the CML mex files
%
% Last updated Feb 10th, 2013

% first clear all the mex files
clear Capacity.c
clear CapacityTableLookup.c
clear ConvEncode.c
clear CreateSRandomInterleaver.c
clear CreateUmtsInterleaver.c
clear CreateCcsdsInterleaver.c
clear Deinterleave.c
clear Depuncture.c
clear InitializeDVBS2.c
clear Interleave.c
clear LdpcEncode.c
clear MpDecode.c
clear Puncture.c
clear RateDematch.c
clear RateMatch.c
clear SisoDecode.c
clear Somap.c
clear ViterbiDecode.c
clear Modulate.c
clear DemodFSK.c
clear Demod2D.c
clear Demod_PNC_FSK.c
clear Somap_PNC.c
clear Capacity_DNC.c

% if this is linux, the files need to be deleted
if isunix
    delete ../mex/*
end

% determine version
tempstring = version;
if (( strcmp(tempstring(1:3), '7.2' )|strcmp(tempstring(1:3), '7.1' ) )&ispc) % version 7.1 or 7.2
    mex -output ../mex/Capacity.dll Capacity.c
    mex -output ../mex/CapacityTableLookup.dll CapacityTableLookup.c
    mex -output ../mex/ConvEncode.dll ConvEncode.c
    mex -output ../mex/CreateSRandomInterleaver.dll CreateSRandomInterleaver.c
    mex -output ../mex/CreateUmtsInterleaver.dll CreateUmtsInterleaver.c
    mex -output ../mex/CreateCcsdsInterleaver.dll CreateCcsdsInterleaver.c
    mex -output ../mex/Deinterleave.dll Deinterleave.c
    mex -output ../mex/Depuncture.dll Depuncture.c
    mex -output ../mex/InitializeDVBS2.dll InitializeDVBS2.c
    mex -output ../mex/Interleave.dll Interleave.c
    mex -output ../mex/LdpcEncode.dll LdpcEncode.c
    mex -output ../mex/MpDecode.dll MpDecode.c
    mex -output ../mex/Puncture.dll Puncture.c
    mex -output ../mex/RateDematch.dll RateDematch.c
    mex -output ../mex/RateMatch.dll RateMatch.c
    mex -output ../mex/SisoDecode.dll SisoDecode.c
    mex -output ../mex/Somap.dll Somap.c
    mex -output ../mex/ViterbiDecode.dll ViterbiDecode.c
    mex -output ../mex/Modulate.dll Modulate.c
    mex -output ../mex/DemodFSK.dll DemodFSK.c
    mex -output ../mex/Demod2D.dll Demod2D.c
    mex -output ../mex/Demod_PNC_FSK.dll Demod_PNC_FSK.c
    mex -output ../mex/Somap_PNC.dll Somap_PNC.c
    mex -output ../mex/Capacity_DNC.dll Capacity_DNC.c
else
    mex -output ../mex/Capacity Capacity.c
    mex -output ../mex/CapacityTableLookup CapacityTableLookup.c
    mex -output ../mex/ConvEncode ConvEncode.c
    mex -output ../mex/CreateSRandomInterleaver CreateSRandomInterleaver.c
    mex -output ../mex/CreateUmtsInterleaver CreateUmtsInterleaver.c
    mex -output ../mex/CreateCcsdsInterleaver CreateCcsdsInterleaver.c
    mex -output ../mex/Deinterleave Deinterleave.c
    mex -output ../mex/Depuncture Depuncture.c
    mex -output ../mex/InitializeDVBS2 InitializeDVBS2.c
    mex -output ../mex/Interleave Interleave.c
    mex -output ../mex/LdpcEncode LdpcEncode.c
    mex -output ../mex/MpDecode MpDecode.c
    mex -output ../mex/Puncture Puncture.c
    mex -output ../mex/RateDematch RateDematch.c
    mex -output ../mex/RateMatch RateMatch.c
    mex -output ../mex/SisoDecode SisoDecode.c
    mex -output ../mex/Somap Somap.c
    mex -output ../mex/ViterbiDecode ViterbiDecode.c
    mex -output ../mex/Modulate Modulate.c
    mex -output ../mex/DemodFSK DemodFSK.c
    mex -output ../mex/Demod2D Demod2D.c
    mex -output ../mex/Demod_PNC_FSK Demod_PNC_FSK.c
    mex -output ../mex/Somap_PNC Somap_PNC.c
    mex -output ../mex/Capacity_DNC Capacity_DNC.c
end


% execute module-specific makefiles - Terry 2/2013
[ cml_home ] = CmlLoadCmlHome('local');
path_cml_mex = fullfile(cml_home, 'source');


% LDPC Decoder
path_ldpc_mex = fullfile(cml_home, 'module', 'chan_code', 'ldpc', ...
                         'decoder', 'src', 'mexsrc');
cd(path_ldpc_mex); make; cd (path_cml_mex);