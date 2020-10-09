//
//  Video.h
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Video : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionaty;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *speaker;
@property (strong, nonatomic) NSString *titleVideo;
@property (strong, nonatomic) NSString *videoDescription;
@property (strong, nonatomic) NSString *link;
@property (assign, nonatomic) BOOL isLike;
@property (nonatomic, strong) NSString *linkVideo;



@end

NS_ASSUME_NONNULL_END
