//
//  UIImageView+AFProgressiveImageDownload.m
//  AFProgressiveImageDownload
//
//  Created by ben on 6/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import "UIImageView+AFProgressiveImageDownload.h"
#import "AFNetworking.h"

@implementation UIImageView (AFProgressiveImageDownload)

- (void)setImageProgressivelyWithImageURLs:(NSArray *)imageURLs
                          placeholderImage:(UIImage *)placeholderImage
                                completion:(AFProgressiveImageDownloadCompletionBlock)completionBlock {
    if (placeholderImage) {
        [self setImage:placeholderImage];
    }
    
    [self fetchNextImage:imageURLs withCompletion:completionBlock];
}

- (void)fetchNextImage:(NSArray *)urls withCompletion:(AFProgressiveImageDownloadCompletionBlock)completionBlock {
    NSMutableArray *remainingUrls = [urls mutableCopy];
    if ([remainingUrls count] == 0) {
        return;
    }
    
    NSURL *imageUrl = remainingUrls[0];
    [remainingUrls removeObjectAtIndex:0];
    
    NSURLRequest *imageRequest = [[NSURLRequest alloc] initWithURL:imageUrl];
    AFImageRequestOperation *operation = [[AFImageRequestOperation alloc] initWithRequest:imageRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, UIImage *responseImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(imageUrl, YES, nil, [remainingUrls count] == 0);
            }
            self.image = responseImage;
        });

        [self fetchNextImage:remainingUrls withCompletion:completionBlock];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(imageUrl, NO, error, [remainingUrls count] == 0);
            }
        });
        
        [self fetchNextImage:remainingUrls withCompletion:completionBlock];
    }];
    [operation start];
}


@end
