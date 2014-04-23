class ThatsNotMyPhoto < StandardError; end

module FlickrPhoto
  def self.find_from_cache(photo_id)
    key = 'photo:' + photo_id.to_s
    photo_hash = FlickrCache.get(key)
    Flickr::Photo.new(JSON.parse(photo_hash)) if photo_hash
  end

  def self.find_from_api(photo_id)
    key = 'photo:' + photo_id.to_s
    begin
      info = flickr.photos.getInfo({ :photo_id => photo_id })
      raise ThatsNotMyPhoto.new unless info.owner.nsid == USER_ID

      sizes = flickr.photos.getSizes({ :photo_id => photo_id })
      photo_hash = {
        'title' => info.title,
        'url_z' => sizes.detect {|size| size['label'] == 'Medium 640'}.source,
        'url_o' => sizes.detect {|size| size['label'] == 'Original'}.source,
        'id' => photo_id
      }

      FlickrCache.set(key, photo_hash.to_json)
      Flickr::Photo.new(photo_hash)
    rescue FlickRaw::FailedResponse; nil; end
  end
end
