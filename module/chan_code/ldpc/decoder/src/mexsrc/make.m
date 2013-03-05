% make.m
% Makefile for LDPC Decoder
% 
% Compile C-mex functions and place in top level binary directory
%  mex/
% and architecture speicific directory
%  mex/<arch>
%
%  To add a C-mex source file for compilation,
%   1. Create string containing compilation command using Windows file
%   separators.
%   
%   2. Create string containing compilation command using Linux/Mac file
%   separators.
%
%   3. Within the ispc if-block below,
%      call the function 'CompileMex' with the compilation command as
%      argument.
%
%
%  Example
%
% if ispc,  
%   comp_initstate_w = ['mex -output <out_dir>\InitState_mx -I.\lib InitState_mx.c .\lib\ldpc-util.c .\lib\math-supp.c']
%   CompileMex(comp_initstate_w);
% else
%   comp_initstate_l = ['mex -output <out_dir>\InitState_mx -I.\lib InitState_mx.c .\lib\ldpc-util.c .\lib\math-supp.c']
%   CompileMex(comp_initstate_l);  
% end
%
%
% Last updated Feb 10th, 2013
function make()

% clear mex files
clear InitState_mx.c
clear Iterate_mx.c

% if linux, delete files
if isunix,
    delete ../mex/*
end

if ispc,
    comp_initstate_w = ['mex -output <out_dir>\InitState_mx -I.\lib InitState_mx.c .\lib\ldpc-util.c .\lib\math-supp.c']
    CompileMex(comp_initstate_W);
    
    comp_iterate_w = ['mex  -output <out_dir>\Iterate_mx -I.\lib Iterate_mx.c .\lib\ldpc-util.c .\lib\math-supp.c'];
    CompileMex(comp_iterate_w);
else    
    comp_initstate_l = ['mex -output <out_dir>/InitState_mx -I./lib InitState_mx.c ./lib/ldpc-util.c ./lib/math-supp.c']
    CompileMex(comp_initstate_l);
    
    comp_iterate = ['mex  -output <out_dir>/Iterate_mx -I./lib Iterate_mx.c ./lib/ldpc-util.c ./lib/math-supp.c'];
    CompileMex(comp_iterate_l);   
end

end


% compile mex function and place in mex/ and mex/<arch>
function CompileMex(comp_str)
comp_str_mex = SetOutputDir( comp_str, '../mex' );
comp_str_arch = SetOutputDir( comp_str, [ '../mex/' lower(computer)] );
eval(comp_str_mex);
eval(comp_str_arch);
end


% set output path
function comp_str_out = SetOutputDir(comp_str_in, output_dir)
% find instances of '<out_dir>' and replace with specified output dir
comp_str_out = strrep(comp_str_in, '<out_dir>', output_dir);
end