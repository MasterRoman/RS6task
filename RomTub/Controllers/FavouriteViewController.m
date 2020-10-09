//
//  FavouriteViewController.m
//  RomTub
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "FavouriteViewController.h"
#import "TableViewCell.h"
#import "EntityVideo+CoreDataProperties.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "Video.h"

@interface FavouriteViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)  NSFetchedResultsController * frc;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (strong,nonatomic) EntityVideo *selectedVideo;
@end

@implementation FavouriteViewController

+(FavouriteViewController *)sharedInstance{
    static FavouriteViewController* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance){
            sharedInstance = [FavouriteViewController new];
        }
    });
    return sharedInstance;
}

- (NSManagedObjectContext *)viewContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

- (NSManagedObjectContext *)newBackgroundContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.newBackgroundContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:[TableViewCell reuseId]];
    [self viewContext].automaticallyMergesChangesFromParent = YES;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[EntityVideo fetchRequest] managedObjectContext:[self viewContext] sectionNameKeyPath:nil cacheName:nil];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.frc performFetch:nil];
    
    if (self.indexPath){
        
        if ((self.frc.fetchedObjects.count != 0) && (![self.frc.fetchedObjects containsObject:self.selectedVideo])){
            
                [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    }
           
        
        self.indexPath = nil;
    
     [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (nonnull TableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TableViewCell reuseId]forIndexPath:indexPath];
    EntityVideo* video = self.frc.fetchedObjects[indexPath.row];
    [cell configureWithItem:video];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.frc.fetchedObjects.count;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UIScreen.mainScreen.bounds.size.width * 0.25;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     EntityVideo *video = self.frc.fetchedObjects[indexPath.row];
    [self.navigationController pushViewController:[[ViewController alloc]initWithNibName:@"ViewController" bundle:[NSBundle mainBundle] video:video indexPath:indexPath ] animated:YES];
    self.indexPath  = indexPath;
    self.selectedVideo = video;
    
}

- (NSIndexPath *)findPath:(Video *)video{
    int i = 0;
    for (EntityVideo *eVideo in self.frc.fetchedObjects) {
        if (eVideo.imageUrl == video.imageUrl){
            return [self.frc.fetchedObjects objectAtIndex:i];
        }
        i++;
    }
   return nil;
}



@end
