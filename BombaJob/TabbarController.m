//
//  TabbarController.m
//  BombaJob
//
//  Created by Sergey Petrov on 6/18/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import "TabbarController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)initTabbar {
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar"]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected"]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:255/255.0 green:167/255.0 blue:104/255.0 alpha:1.0]];
    
    self.moreNavigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.moreNavigationController.navigationBar.topItem.title = NSLocalizedString(@"More.Title", @"More.Title");
    [self.moreNavigationController setDelegate:self];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.navigationBar.topItem.rightBarButtonItem = nil;
}

#pragma mark -
#pragma mark System

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ? NO : [bSettings sharedbSettings].shouldRotate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbar];
}

@end
