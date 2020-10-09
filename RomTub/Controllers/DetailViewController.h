//
//  DetailViewController.h
//  RomTub
//
//  Created by Admin on 27.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil video:(Video *)video;

@end

NS_ASSUME_NONNULL_END
