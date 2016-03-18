# What

A dashboard visualising data from the Rapture index site. [Demo here.](http://davidedc.github.io/Rapture-index-dashboard/)

A possible description as follows: "[the Rapture index](http://www.raptureready.com/) is a Dow Jones Industrial Average of end time activity". The [related wikipedia page](https://en.wikipedia.org/wiki/Rapture_Ready) contains most interesting factoids about the index and the site.

Uses the [Rapture Index CORS API](https://github.com/davidedc/Rapture-index-cors-api) (another project of mine).

<p align="center">
  <img width="49%" src="https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-16-15_31_18.gif">
  <img width="49%" src="https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-16-15_40_59.gif">
</p>

<p align="center">
  <img width="49%" src="https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-16-15_46_12.gif">
  <img width="49%" src="https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-16-15_48_03.gif">
</p>

[![vimeo player screenshot](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/vimeo-player-screenshot.png)](https://vimeo.com/159250506)

![img6](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-17-16.18.33.png)
![img6](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/IMG_2747.JPG)
![img7](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-17-16.16.57.png)
![img7](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/IMG_2749.JPG)
![img8](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/2016-03-17-16.16.46.png)
![img8](https://raw.githubusercontent.com/davidedc/Rapture-index-dashboard/master/readme-images/IMG_2751.JPG)

# Why

For sure you don't want to miss-out on these vital stats :-)

# Reception

"Look at him, with his ironic digital art pieces on the state of modern news reportage." - @stilliterate


# How

This is a static website which animates through the data fetched from the [Rapture Index CORS API](https://github.com/davidedc/Rapture-index-cors-api). Since the API uses cors, no further servers are needed, just the static site is OK.

There is some coffeescript to load the data and place it in the right divs and to manage the animations. To compile coffeescript to javascript transparently as you change the code, just use ```coffee --watch -c --bare --map *.coffee```.


# Disclaimer

There is no affiliation between this project and the Raptureready website. If you like the site, please consider donating to them [here](https://www.raptureready.com/rr-an-donation.php). 