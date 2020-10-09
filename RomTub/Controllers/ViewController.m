//
//  ViewController.m
//  RomTub
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "EntityVideo+CoreDataProperties.h"
#import "SharedViewController.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) EntityVideo *localVideo;

@end

static void *likeContext = &likeContext;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
 
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil video:(nonnull EntityVideo *)video indexPath:(NSIndexPath *)indexPath{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        _localVideo = video;
        _indexPath = indexPath;
        [self subsribeOnEvent];
    }
    return self;
    
}


- (void)subsribeOnEvent{
    [self.localVideo addObserver:self forKeyPath:@"like" options:NSKeyValueObservingOptionNew context:&likeContext];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (context == likeContext){
        [[SharedViewController sharedInstance] updateVideo: self.localVideo.time];
        
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (NSManagedObjectContext *)viewContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

- (NSManagedObjectContext *)newBackgroundContext {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.newBackgroundContext;
}


- (IBAction)sharedButtonDidTapped:(UIButton *)sender {
    
    UIActivityViewController *activityVC;
    activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.localVideo.link] applicationActivities:nil];
    UIDevice *device = [[UIDevice alloc] init];
    //if iPad
    if ( !(device.userInterfaceIdiom == UIUserInterfaceIdiomPhone)) {
        if ([sender isKindOfClass:[UIView class]]) {
            activityVC.popoverPresentationController.sourceView = [sender superview];
            activityVC.popoverPresentationController.sourceRect = [sender frame];
        }
    }
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)likeButtonDidTapped:(UIButton *)sender {
    self.localVideo.isLike = !self.localVideo.isLike;
    if (!self.localVideo.isLike){
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
        NSManagedObjectContext *context = [self newBackgroundContext];
        [context performBlockAndWait:^{
            EntityVideo *video = [[[EntityVideo fetchRequest] execute:nil] objectAtIndex: self.indexPath.row];
            [context deleteObject: video];
        }];
        [context save:nil];
    } else
    {
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateNormal];
        NSManagedObjectContext *context = [self newBackgroundContext];
              [context performBlockAndWait:^{
                  EntityVideo *video = [[EntityVideo alloc] initWithContext:context];
                  video.imageUrl = _localVideo.imageUrl;
                  video.isLike = _localVideo.isLike;
                  video.linkVideo = _localVideo.linkVideo;
                  video.speaker = _localVideo.speaker;
                  video.time = _localVideo.time;
                  video.titleVideo = _localVideo.titleVideo;
              }];
        
              [context save:nil];
    }
}


- (void)setupView{
   
        self.titleLabel.text = self.localVideo.titleVideo;
        self.speakerLabel.text = self.localVideo.speaker;
        self.descriptionLabel.text = self.localVideo.videoDescription;
    
   
    self.view.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
    
    
    self.navigationController.navigationBar.items.firstObject.title = @"";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:42.0/255 green:17.0/255 blue:20.0/255 alpha:1];
    
    self.playButton.layer.cornerRadius = self.playButton.bounds.size.height / 2.0;
   
    [self.playButton setImage:[UIImage imageNamed:@"player"] forState:UIControlStateNormal];
    
    //self.imageView.image = self.localVideo.image;
    
    if (!self.localVideo.isLike){
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
    } else
    {
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateNormal];
    }
    
    [self.shareButton setImage:[UIImage systemImageNamed:@"square.and.arrow.up"] forState:UIControlStateNormal];

   
    
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.localVideo removeObserver:self forKeyPath:@"like"];
    [self.navigationController.navigationBar setHidden:YES];
}

@end
