Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each { |f| require f }
require 'sinatra'

# set :environment, :production
set :environment, :development
set :logging, :true

FEATURED_PHOTO_ID = 8204599778
PHOTOSET_ID = 72157638729659183
PER_PAGE = 24

get '/' do
  send_file 'views/wip.html'
end

get '/photography' do
  photos = Flickr.fetch(1, 1, PER_PAGE)
  erb :page, :locals => { :featured_photo => Flickr.find(FEATURED_PHOTO_ID), :photos => photos, :next_page => 2 }
end

get '/photo/:id' do |id|
  photo_id = id.to_i.abs
  photo = Flickr.find(photo_id)
  if photo
    erb :photo, :locals => { :photo => photo }
  else
    '404'
  end
end

get '/page/:page' do |page|
  page = page.to_i.abs

  photos = Flickr.fetch(page, page, PER_PAGE)
  if photos
    next_page = page + 1 if photos.count == PER_PAGE
    erb :page, :locals => { :featured_photo => nil, :photos => photos, :next_page => next_page }
  else
    '404'
  end
end

get %r{^/pages/(\d+\-\d+)$} do |page_range|
  first_page = page_range.split('-').first.to_i.abs
  last_page  = page_range.split('-').last.to_i.abs

  photos = Flickr.fetch(first_page, last_page, PER_PAGE)
  if photos
    next_page = last_page + 1 if photos.count == PER_PAGE * last_page
    erb :page, :locals => { :featured_photo => nil, :photos => photos, :next_page => next_page }
  else
    '404'
  end
end

get '/pages/:pages' do |pages|
  pages = pages.to_i.abs

  photos = Flickr.fetch(1, pages, PER_PAGE)
  if photos
    next_page = pages + 1 if photos.count == PER_PAGE * pages
    erb :page, :locals => { :featured_photo => nil, :photos => photos, :next_page => next_page }
  else
    '404'
  end
end

get '/api/page/:page' do |page|
  content_type :json

  photos = Flickr.fetch(page.to_i.abs, page.to_i.abs, PER_PAGE).map{ |photo| photo.to_json }
  { 'photos' => photos }.to_json
end

get '/api/pages/:pages' do |pages|
  content_type :json

  photos = Flickr.fetch(1, (16 * pages.to_i.abs), PER_PAGE).map{ |photo| photo.to_json }
  { 'photos' => photos }.to_json
end

get %r{^/api/pages/(\d+\-\d+)$} do |page_range|
  content_type :json

  first_page = page_range.split('-').first.to_i.abs
  last_page  = page_range.split('-').last.to_i.abs
  per_page   = 16 * (last_page - first_page)

  photos = Flickr.fetch(first_page, last_page, PER_PAGE).map{ |photo| photo.to_json }
  { 'photos' => photos }.to_json
end
