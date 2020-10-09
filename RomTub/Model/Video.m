//
//  Video.m
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "Video.h"

@implementation Video

- (instancetype)initWithDictionary:(NSDictionary *)dictionaty{
    self = [super init];
    if (self){
        _imageUrl = dictionaty[@"itunes:image"];
        _time = dictionaty[@"itunes:duration"];
        _speaker = dictionaty[@"media:credit"];
        _titleVideo = dictionaty[@"title"];
        _videoDescription = dictionaty[@"description"];
        _link = dictionaty[@"link"];
        _linkVideo = dictionaty[@"media:content"];
        _isLike = NO;
    }
    return self;
}



@end
