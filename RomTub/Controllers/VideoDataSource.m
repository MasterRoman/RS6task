//
//  VideoDataSource.m
//  RomTub
//
//  Created by Admin on 07.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "VideoDataSource.h"
#import "MainTableViewCell.h"
#import "Video.h"
#import "VideoService.h"
#import "XMLParser.h"
#import "SharedViewController.h"


@interface VideoDataSource ()

@property (nonatomic,strong) NSMutableArray <Video *> *dataSource;
@property (strong, nonatomic) VideoService *videoService;

@end


@implementation VideoDataSource



- (void)configureWithSearchData:(NSArray<Video *> *)array{
    
    self.dataSource = [NSMutableArray arrayWithArray:array];
    
    
}





- (instancetype)initWithArray:(NSArray<Video *> *)array{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithArray: array];
        self.videoService = [[VideoService alloc] initWithParser:[XMLParser new]];
        
        
    }
    return self;
}



- (nonnull MainTableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MainTableViewCell reuseId] forIndexPath:indexPath];
    Video *video = self.dataSource[indexPath.row];
    if (!video.image){
        [[SharedViewController sharedInstance] loadImageForIndexPath:indexPath];
        
    }
    [cell configureWithItem:video];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",self.dataSource.count);
     return self.dataSource.count;
}




@end
