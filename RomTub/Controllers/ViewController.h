//
//  ViewController.h
//  RomTub
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EntityVideo;
NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil video:(EntityVideo *)video indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
