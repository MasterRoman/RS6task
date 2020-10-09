//
//  VideoService.h
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ParserProtocol.h"

@class Video;

NS_ASSUME_NONNULL_BEGIN

@interface VideoService : NSObject

- (instancetype)initWithParser:(id<ParserProtocol>)parser;

- (void)loadVideos:(void(^)(NSArray <Video*>*,NSError *))completion;
- (void)loadImageForURL:(NSString *)url completion:(void (^)(UIImage *))completion;
- (void)cancelDownloadingForUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
