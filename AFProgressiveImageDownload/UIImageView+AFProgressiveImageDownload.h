//
//  UIImageView+AFProgressiveImageDownload.h
//  AFProgressiveImageDownload
//
//  Created by ben on 6/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AFProgressiveImageDownloadCompletionBlock)(NSURL *imageURL, BOOL success, NSError *error, BOOL completed);

@interface UIImageView (AFProgressiveImageDownload)

- (void)setImageProgressivelyWithImageURLs:(NSArray *)imageURLs
                          placeholderImage:(UIImage *)placeholderImage
                                completion:(AFProgressiveImageDownloadCompletionBlock)completionBlock;


@end
