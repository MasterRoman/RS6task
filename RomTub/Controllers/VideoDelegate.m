//
//  VideoDelegate.m
//  RomTub
//
//  Created by Admin on 13.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "VideoDelegate.h"
#import "Video.h"
#import "SharedViewController.h"
#import "VideoService.h"
#import "DetailViewController.h"

@interface VideoDelegate()
@property (nonatomic,strong) NSMutableArray <Video *> *dataSource;
@property (strong, nonatomic) VideoService *videoService;

@end

@implementation VideoDelegate


- (instancetype)initWithArray:(NSArray<Video *> *)array{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithArray: array];
        self.videoService = [[SharedViewController sharedInstance] videoService];
     
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UIScreen.mainScreen.bounds.size.width * 0.25;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Video *video = self.dataSource[indexPath.row];
    
    [SharedViewController.sharedInstance.navigationController pushViewController:[[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle] video:video ] animated:YES];

}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    Video *video = self.dataSource[indexPath.row];
    [self.videoService cancelDownloadingForUrl:video.imageUrl];
}

@end
