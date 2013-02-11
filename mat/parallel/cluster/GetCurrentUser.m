function user = GetCurrentUser()                                        
  [dontcare user] = system('whoami');                                     
user = user(1:end-1);                                                   
end
