//
//  VideoDataSource.h
//  RomTub
//
//  Created by Admin on 07.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Video;

@interface VideoDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithArray:(NSArray <Video *> *)array;
- (void)configureWithSearchData:(NSArray <Video *> *)array;

@end

NS_ASSUME_NONNULL_END
