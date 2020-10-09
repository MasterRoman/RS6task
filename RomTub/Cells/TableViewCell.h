//
//  TableViewCell.h
//  RomTub
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EntityVideo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureWithItem:(EntityVideo *)video;
+ (NSString *)reuseId;

@end

NS_ASSUME_NONNULL_END
