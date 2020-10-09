//
//  RootTabBarController.m
//  RomTub
//
//  Created by Admin on 25.08.2020.
//  Copyright © 2020 MasterCORP. All rights reserved.
//

#import "RootTabBarController.h"

#import "FavouriteViewController.h"
#import "SharedViewController.h"


@interface RootTabBarController ()

@property (nonatomic,strong) SharedViewController *standartTab;
@property (nonatomic,strong) FavouriteViewController *favouriteTab;

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabs];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self.standartTab.navigationController popToRootViewControllerAnimated:NO];
    [self.standartTab.navigationController.navigationBar setHidden:YES];
    [self.favouriteTab.navigationController popToRootViewControllerAnimated:NO];
    [self.favouriteTab.navigationController.navigationBar setHidden:YES];
}

- (void)setUpTabs{
    
    self.standartTab = [SharedViewController sharedInstance];
    UITabBarItem *standartTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    self.standartTab.tabBarItem = standartTabBarItem;
    
    UINavigationController *standartNC = [[UINavigationController alloc] initWithRootViewController:self.standartTab];
    [standartNC.navigationBar setHidden:YES];
    
    self.favouriteTab = [FavouriteViewController new];
    UITabBarItem *favouriteTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage systemImageNamed:@"star"] selectedImage:[UIImage systemImageNamed:@"star.fill"]];
    self.favouriteTab.tabBarItem = favouriteTabBarItem;
    
    UINavigationController *favouriteNC = [[UINavigationController alloc] initWithRootViewController:self.favouriteTab];
    [favouriteNC.navigationBar setHidden:YES];
    
    self.viewControllers = @[standartNC,favouriteNC];
    self.tabBar.barTintColor =  [UIColor colorWithRed:44.0/255 green:44.0/255 blue:46.0/255 alpha:1];
    self.tabBar.tintColor = [UIColor whiteColor];
      
}

@end
