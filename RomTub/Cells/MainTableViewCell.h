//
//  MainTableViewCell.h
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Video;

@interface MainTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureWithItem:(Video *)video;
+ (NSString *)reuseId;

@end

NS_ASSUME_NONNULL_END
