function listing = GetDirectoryListing( directory )
listing = dir( [ directory '/*.mat' ] );
end
