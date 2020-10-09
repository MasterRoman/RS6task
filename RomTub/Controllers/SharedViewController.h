//
//  SharedViewController.h
//  RomTub
//
//  Created by Admin on 26.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SharedViewController : UIViewController

+(SharedViewController *)sharedInstance;
- (void)loadImageForIndexPath:(NSIndexPath *)indexPath;
- (void)updateVideo:(NSString *)link;

@property (strong, nonatomic) VideoService *videoService;

@end

NS_ASSUME_NONNULL_END
