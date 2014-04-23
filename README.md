sinatra-photography-portfolio
========

Photography portfolio, using Sinatra 1.4.3 and Ruby 2.0.0-p353

Start the server using `foreman start`. To debug, use `pry-remote`. Foreman is required to set up the environment variables.

---

The homepage shows numerous photos in a thumbnail format. There is one featured photo that is the full width of the webpage, the rest are split to 4 column rows.

The photo feed will be 'endless': [when the user scrolls down the end of the page](https://dl.dropboxusercontent.com/sh/zs1ry3urfkwyyse/iO9_A2pCPt/scrolled-down.jpg?token_hash=AAFLR6emkDwpHw6-gLFMtDi6m34H1diyWyQbS_ZzwFQ74Q), it will load X more rows of photos.

When the user hovers over a photo, they are presented with some ['full-screen' icon](https://dl.dropboxusercontent.com/sh/zs1ry3urfkwyyse/ZRgk2s9xiV/hover-thumbnail.jpg?token_hash=AAFLR6emkDwpHw6-gLFMtDi6m34H1diyWyQbS_ZzwFQ74Q). Clicking on the thumbnail will load the full-sized image depending on the webpage size.

Fullscreen view will consist of link to flickr permalink, and if provided: title, caption, date, some metadata about photo - designs not decided
Background will be the same image, but taking up the full width + height of the webpage fullpage, but uber-blurry.


##Notes
Light-blue: `#80b7d8`

Dark-blue: `#2a3c46`

##Designs

![Homepage](https://dl.dropboxusercontent.com/sh/zs1ry3urfkwyyse/GyRcvY09GT/main-page.jpg?token_hash=AAFLR6emkDwpHw6-gLFMtDi6m34H1diyWyQbS_ZzwFQ74Q "Homepage")

![Full-screen view](https://dl.dropboxusercontent.com/sh/zs1ry3urfkwyyse/Ka5ve_SbnM/fullscreen-photo.jpg?token_hash=AAFLR6emkDwpHw6-gLFMtDi6m34H1diyWyQbS_ZzwFQ74Q "Full-screen view")
