//
//  UIImageView+AFProgressiveImageDownload.m
//  AFProgressiveImageDownload
//
//  Created by ben on 6/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import "UIImageView+AFProgressiveImageDownload.h"
#import "UIImageView+AFNetworking.h"

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
    
    NSMutableURLRequest *imageRequest = [NSMutableURLRequest requestWithURL:imageUrl];
    [imageRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURLRequest:imageRequest placeholderImage:self.image success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        strongSelf.image = image;
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(imageUrl, YES, nil, [remainingUrls count] == 0);
            });
        }
        
        [strongSelf fetchNextImage:remainingUrls withCompletion:completionBlock];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(imageUrl, NO, error, [remainingUrls count] == 0);
            });
        }
        
        [weakSelf fetchNextImage:remainingUrls withCompletion:completionBlock];
    }];
}

@end
