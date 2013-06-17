//
//  Sync.m
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import "Sync.h"

@implementation Sync

@synthesize delegate = _delegate;
@synthesize webService, xmlErrorOccured;

#pragma mark -
#pragma mark Init

- (void)startSync {
    self.xmlErrorOccured = FALSE;
	if (webService == nil)
		webService = [[WebService alloc] init];
	[webService setDelegate:self];
	[webService getConfiguration];
}

- (void)finishSync {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(syncFinished:)])
		[self.delegate syncFinished:self];
}

#pragma mark -
#pragma mark Workers

- (void)serviceError:(id)sender error:(NSString *)errorMessage {
    self.xmlErrorOccured = TRUE;
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(syncError:error:)])
		[self.delegate syncError:self error:errorMessage];
}

- (void)configFinshed:(id)sender {
    if (!self.xmlErrorOccured)
        [self.webService getCategories];
}

- (void)getCategoriesFinished:(id)sender {
    if (!self.xmlErrorOccured)
        [self.webService getTextContent];
}

- (void)getTextContentFinished:(id)sender {
    if (!self.xmlErrorOccured)
        [self finishSync];
}

@end
