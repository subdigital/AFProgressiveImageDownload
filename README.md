# AFProgressiveImageDownload

A category on UIView that allows you to progressively download images. Leverages AFNetworking's image cache to make seamless image enhancements really easy.

## Why is this useful?

It is common to download smaller images for use as thumbnails when rendering many records in a table view.  When you visit the detail for a given page, you'd like to download a higher resolution image, but use the one we've already downloaded as a starting point, so the user doesn't get a flash of no content when the detail view controller loads.

This leverages AFNetworking's image cache, so all you need is a set of progressively enhanced URLs.  It supports any number of requests, but you'll probably only use 2 (small/large).

## Requirements

- iOS 6.0
- AFNetworking

## Installation

TODO

## Usage

Import the header:

````objc
#import "UIImageView+AFProgressiveDownload.h"
````

Prepare a list of URLs:

````objc
NSArray *urls = @[ smallUrl, largeUrl ];
````

Load it on the image view:

````objc
[self.imageView setImageProgressivelyWithImageURLs:progressiveURLS
                                      placeholderImage:self.placeholderImage
                                            completion:^(NSURL *imageURL, BOOL success, NSError *error, BOOL completed) {
                                                NSLog(@"Completed %@", imageURL);

                                                // just to make the effect more obvious
                                                sleep(1);
    }];
````

## Demo

Check out the provided sample project for a live demo.  Here's what it looks like:

-![Loading the first image](https://benpublic.s3.amazonaws.com/afprogressivedownload-1.png)
-![Loading the second image](https://benpublic.s3.amazonaws.com/afprogressivedownload-2.png)

## License

AFProgressiveImageDownload is provided under the MIT license.  See LICENSE for specifics.

## Attribution

This library is made possible by [AFNetworking](http://afnetworking.com), which is doing all of the heavy lifting here.  The demo project uses Creative Commons licensed images.  Credits to Eugene Kukulka and WPZOOM.

Created as part of the Objective-C Hackathon on June 29th, 2013.
