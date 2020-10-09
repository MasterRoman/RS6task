//
//  ParserProtocol.h
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ParserProtocol <NSObject>

- (void)parseVideos:(NSData *)data completion:(void(^)(NSArray <Video *> *,NSError *))completion;

@end

NS_ASSUME_NONNULL_END
