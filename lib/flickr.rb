require 'flickraw'

FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
FlickRaw.api_key = ENV['FLICKR_API_KEY']
USER_ID = ENV['FLICKR_USER_ID']

module Flickr
  def self.fetch(page_from, page_to, per_page)
    begin_range = (page_from - 1) * per_page
    end_range = (page_to * per_page) - 1

    cache = FlickrPhotoset.find_from_cache(PHOTOSET_ID)
    return cache[begin_range..end_range] unless cache.nil?

    api = FlickrPhotoset.find_from_api(PHOTOSET_ID)
    return api[begin_range..end_range] unless api.nil?

    []
  end

  def self.find(photo_id)
    cache = FlickrPhoto.find_from_cache(photo_id)
    return cache unless cache.nil?

    api = FlickrPhoto.find_from_api(photo_id)
    return api unless api.nil?

    nil #maybe 404
    # rescue ThatsNotMyPhoto error
  end

  class Photo
    # {"id"=>"11113751194", "secret"=>"9b31c3b5d6", "server"=>"3749", "farm"=>4, "title"=>"DSC_1465", "isprimary"=>"1",
    # "url_z"=>"http://farm4.staticflickr.com/3749/11113751194_9b31c3b5d6_z.jpg", "height_z"=>"427", "width_z"=>"640",
    # "url_o"=>"http://farm4.staticflickr.com/3749/11113751194_13a5b6a677_o.jpg", "height_o"=>"854", "width_o"=>"1280"
    def initialize(photo_hash)
      @title = photo_hash['title'] ? photo_hash['title'] : "Untitled"
      @thumbnail_image_url = photo_hash['url_z']
      @original_image_url = photo_hash['url_o']
      @photo_id = photo_hash['id']
    end

    def to_json
      {
        'title' => @title,
        'thumbnail_image_url' => @thumbnail_image_url,
        'original_image_url' => @original_image_url,
        'id' => @photo_id
      }.to_json
    end

    def title
      @title
    end

    def thumbnail_image_url
      @thumbnail_image_url
    end

    def original_image_url
      @original_image_url
    end

    def photo_id
      @photo_id
    end

    # def get_exif(id)
    #   camera, lens, focal length (lens model/info), aperture/shutter speed/iso
    #   exif_hash = flickr.photos.getExif(:photo_id => id)["exif"]
    # end

    # def permalink
    #   "http://www.flickr.com/photos/tom-sabin/#{@photo_id}/"
    # end
  end
end
