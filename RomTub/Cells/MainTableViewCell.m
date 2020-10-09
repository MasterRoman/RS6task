//
//  MainTableViewCell.m
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "MainTableViewCell.h"
#import "Video.h"

@interface MainTableViewCell()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *horizontalTimeConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verticalTimeConstraint;


@end

@implementation MainTableViewCell

@synthesize imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
    
    UIScreen *screen = [UIScreen mainScreen];
    if (screen.bounds.size.height>screen.bounds.size.width){
        self.verticalTimeConstraint.constant = 10;
        self.horizontalTimeConstraint.constant = -60;
    } else
    {
        self.verticalTimeConstraint.constant = 20;
        self.horizontalTimeConstraint.constant = -80;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)configureWithItem:(Video *)video{
    self.titleLabel.text = video.titleVideo;
    

    self.imageView.image = video.image;
    NSString *str = [video.time substringWithRange:NSMakeRange(0, 3)];
    if ([str  isEqual: @"00:"]){
        video.time = [video.time substringFromIndex:3];
    }
    self.timeLabel.text = video.time;
    self.speakerLabel.text = video.speaker;
    
}

+ (NSString *)reuseId{
    return @"CellId";
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateViewsLayout];
    
}

- (void)updateViewsLayout {
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        self.verticalTimeConstraint.constant = 10;
        self.horizontalTimeConstraint.constant = -60;
       
    } else {
        self.verticalTimeConstraint.constant = 20;
        self.horizontalTimeConstraint.constant = -80;
       
    }
}

@end
