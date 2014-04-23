module FlickrPhotoset
  def self.find_from_cache(photoset_id)
    key = 'photoset:' + photoset_id.to_s
    photos = FlickrCache.get(key)
    JSON.parse(photos).map { |photo_hash| Flickr::Photo.new(JSON.parse(photo_hash)) } if photos
  end

  def self.find_from_api(photoset_id)
    key = 'photoset:' + photoset_id.to_s
    begin
      response = flickr.photosets.getPhotos({ :photoset_id => photoset_id, :extras => 'url_z, url_o', :page => 1, :per_page => 500})
      photos = response.photo.inject([]) do |result, element|
        result << { 'title' => element['title'],
                    'url_z' => element['url_z'],
                    'url_o' => element['url_o'],
                    'id' => element['id']}
        result
      end

      FlickrCache.set(key, photos.map { |photo| photo.to_json })
      photos.map { |photo_hash| Flickr::Photo.new(photo_hash) }
    rescue FlickRaw::FailedResponse
      response = []
    end
  end
end
