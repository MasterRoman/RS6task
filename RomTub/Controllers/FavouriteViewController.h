//
//  FavouriteViewController.h
//  RomTub
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;

NS_ASSUME_NONNULL_BEGIN

@interface FavouriteViewController : UIViewController

+(FavouriteViewController *)sharedInstance;

-(NSIndexPath *)findPath:(Video *)video;

@end

NS_ASSUME_NONNULL_END
