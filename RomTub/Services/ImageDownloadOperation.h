//
//  ImageDownloadOperation.h
//  RomTub
//
//  Created by Admin on 26.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloadOperation : NSOperation

@property (nonatomic,strong) UIImage *image;
@property (nonatomic, copy) void(^completion)(UIImage *);

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
