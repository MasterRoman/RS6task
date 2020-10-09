//
//  SharedViewController.m
//  RomTub
//
//  Created by Admin on 26.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "SharedViewController.h"
#import "Video.h"
#import "MainTableViewCell.h"
#import "XMLParser.h"
#import "DetailViewController.h"
#import "VideoDataSource.h"
#import "VideoDelegate.h"
#import "AppDelegate.h"
#import "EntityVideo+CoreDataProperties.h"
#import "SearchingTextField.h"

@interface SharedViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet SearchingTextField *searchingBar;


@property (nonatomic,strong) NSArray <Video *> *dataSource;
@property (nonatomic,strong) NSArray <Video *> *searchDataSource;

@property (strong, nonatomic) VideoDataSource *videoDataSource;

@property (strong, nonatomic) VideoDelegate *videoDelegate;

@property (strong, nonatomic) NSString *searchingString;

@property (assign,nonatomic) BOOL isFilter;

@end

@implementation SharedViewController


+ (SharedViewController *)sharedInstance{
    static SharedViewController* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance){
            sharedInstance = [SharedViewController new];
        }
    });
    return sharedInstance;
}


- (IBAction)textFieldDidChanged:(SearchingTextField *)sender {
    self.searchingString = self.searchingBar.text;
    [self updateSearchArray:self.searchingString];
    
}

- (void)updateSearchArray:(NSString *)searchString{
    
    if (self.searchingString.length == 0){
        self.isFilter = NO;
    } else
    {
        self.isFilter = YES;
        NSMutableArray *searchArray = [NSMutableArray new];
        for (Video *video in  self.dataSource) {
            NSRange stringRange=[[video.speaker lowercaseString] rangeOfString:[self.searchingString lowercaseString] options:NSCaseInsensitiveSearch];
            if (stringRange.location !=NSNotFound){
                
                [searchArray addObject:video];
            }
        }
        self.searchDataSource = [NSArray arrayWithArray:searchArray];
    }
    
    
    [self.videoDataSource configureWithSearchData:self.searchDataSource];
    
    [self.tableView reloadData];
    
    
}




- (void)hideWhenTappedAround{
    UITapGestureRecognizer *gesturer = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self
                                     action:@selector(hide)];
    gesturer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gesturer];
}

-(void)hide{

    [self.searchingBar resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self.videoDataSource;
    self.videoService = [[VideoService alloc] initWithParser:[XMLParser new]];
    self.dataSource = [NSArray new];
    [self hideWhenTappedAround];
    self.searchingBar.delegate = self;
   

     [self startLoading];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:[MainTableViewCell reuseId]];
    
  
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}

- (void)updateVideo:(NSString *)link{
    NSMutableArray *ma = [NSMutableArray arrayWithArray:self.dataSource];
    for (Video *video in ma) {
        if (video.time == link){
            video.isLike = !video.isLike;
            self.dataSource = [NSArray arrayWithArray:ma];
            return;
        }
    }
}

- (void)startLoading{
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
    dispatch_async(queue, ^{
        [self.videoService loadVideos:^(NSArray<Video *> *videos, NSError * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error){
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                             message:[NSString stringWithFormat:@"%@", error]
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                    
                } else
                {
                    weakSelf.dataSource = videos;
                    self.videoDataSource = [[VideoDataSource alloc ] initWithArray:self.dataSource];
                    self.tableView.dataSource = self.videoDataSource;
                    self.videoDelegate = [[VideoDelegate alloc] initWithArray:self.dataSource];
                    self.tableView.delegate = self.videoDelegate ;
                    [weakSelf.tableView reloadData];
                }
                
            });
            
        }];
    });
}




- (void)loadImageForIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    Video *video = self.dataSource[indexPath.item];
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
    dispatch_async(queue, ^{
        [self.videoService loadImageForURL:video.imageUrl completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.dataSource[indexPath.row].image = image;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
        }];
    });
    
}




@end
