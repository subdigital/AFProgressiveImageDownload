//
//  AFViewController.m
//  AFProgressImageDownload
//
//  Created by ben on 6/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFProgressiveImageDownload.h"

// These images are Creative Commons licensed.  Copyright Eugene Kukulka
// http://www.flickr.com/photos/eugene-kukulka/
#define SMALL_PHOTO_URL @"http://farm8.staticflickr.com/7205/6909138889_154a903bcb_n.jpg"
#define LARGE_PHOTO_URL @"http://farm8.staticflickr.com/7205/6909138889_154a903bcb_z.jpg"

@interface ViewController ()

@property (nonatomic, strong) UIImage *placeholderImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // This placeholder image is based on an icon from WPZOOM - http://www.wpzoom.com
    self.placeholderImage = [UIImage imageNamed:@"img-placeholder.png"];
}

- (IBAction)startDownload:(id)sender {
    self.statusLabel.text = @"";
    NSArray *progressiveURLS = @[[NSURL URLWithString:SMALL_PHOTO_URL],
                                 [NSURL URLWithString:LARGE_PHOTO_URL]];

    [self.imageView setImageProgressivelyWithImageURLs:progressiveURLS
                                      placeholderImage:self.placeholderImage
                                            completion:^(NSURL *imageURL, BOOL success, NSError *error, BOOL completed) {
                                                NSInteger index = [progressiveURLS indexOfObject:imageURL];
                                                NSString *status = nil;
                                                if (success) {
                                                    status = [NSString stringWithFormat:@"Finished with URL: %d",
                                                             index];
                                                } else {
                                                    status = [NSString stringWithFormat:@"ERROR: %@", error];
                                                }
                                                
                                                if (completed) {
                                                    status = [status stringByAppendingString:@"\n\nDone!"];
                                                }
                                                
                                                NSLog(@"%@", status);
                                                NSString *text = self.statusLabel.text;
                                                text = [text stringByAppendingFormat:@"\n%@", status];
                                                self.statusLabel.text = text;
                                                
                                                // just to make the effect more obvious
                                                sleep(1);
    }];
}

@end
