require './app'
require 'rake'

task :default => ['flickr:cache_photoset']

namespace 'flickr' do
  task :cache_photoset do
    FlickrPhotoset.find_from_api(PHOTOSET_ID)
  end
end