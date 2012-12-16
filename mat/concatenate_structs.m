function struct_concat = concatenate_structs( struct1, struct2 )

% read the fields of struct 1
fields = fieldnames(struct1);

N = length(fields);

for k = 1:N,
    struct2 = setfield(struct2, fields{k}, getfield( struct1, fields{k}) );
end

struct_concat = struct2;
end