//
//  About.m
//  BombaJob
//
//  Created by Sergey Petrov on 6/18/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import "About.h"

@interface About ()

@end

@implementation About

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

@end
