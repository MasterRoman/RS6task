//
//  TableViewCell.m
//  RomTub
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "TableViewCell.h"


@interface TableViewCell()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *horizontalTimeConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verticalTimeConstraint;
@end

@implementation TableViewCell


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



- (void)configureWithItem:(EntityVideo *)video{
    self.titleLabel.text = video.titleVideo;
    

    
    NSString *str = [video.time substringWithRange:NSMakeRange(0, 3)];
    if ([str  isEqual: @"00:"]){
        video.time = [video.time substringFromIndex:3];
    }
    self.timeLabel.text = video.time;
    self.speakerLabel.text = video.speaker;
    
    
}

+ (NSString *)reuseId{
    return @"CellIdd";
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
