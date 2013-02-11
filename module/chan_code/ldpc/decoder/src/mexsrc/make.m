% makefile for LDPC decoder
%
% Last updated Feb 10th, 2013


% clear mex files
clear InitState_mx.c
clear Iterate_mx.c


% if linux, delete files
if isunix,
    delete ../mex/*
end


if ispc,
    mex  -output ../mex/InitState_mx.dll -I./lib InitState_mx.c ./lib/ldpc-util.c ./lib/math-supp.c
    mex  -output ../mex/Iterate_mx.dll -I./lib Iterate_mx.c ./lib/ldpc-util.c ./lib/math-supp.c
else
    mex  -output ../mex/InitState_mx -I./lib InitState_mx.c ./lib/ldpc-util.c ./lib/math-supp.c
    mex  -output ../mex/Iterate_mx -I./lib Iterate_mx.c ./lib/ldpc-util.c ./lib/math-supp.c
end