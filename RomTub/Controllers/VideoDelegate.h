//
//  VideoDelegate.h
//  RomTub
//
//  Created by Admin on 13.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class  Video;

NS_ASSUME_NONNULL_BEGIN

@interface VideoDelegate : NSObject <UITableViewDelegate>


- (instancetype)initWithArray:(NSArray <Video *> *)array;

@end

NS_ASSUME_NONNULL_END
