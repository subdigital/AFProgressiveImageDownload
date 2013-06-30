//
//  AFViewController.h
//  AFProgressImageDownload
//
//  Created by ben on 6/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)startDownload:(id)sender;

@end
