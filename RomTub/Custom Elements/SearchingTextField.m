//
//  SearchingTextField.m
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "SearchingTextField.h"

@interface SearchingTextField () 

@end

@implementation SearchingTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpTextField];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpTextField];
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(6, 0, 30, 32);
}

- (void)setUpTextField{
    self.layer.cornerRadius = 27.0;
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20]];
    self.placeholder = @"Поиск";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magnifier"]];
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
  
    self.textColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor darkGrayColor];
    
    
}

@end
