function listing = GetDirectoryListing( directory )
listing = dir( [ directory filesep '*.mat' ] );
end
