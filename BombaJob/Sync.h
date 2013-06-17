//
//  Sync.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"

@protocol SyncDelegate <NSObject>
@optional
- (void)syncError:(id)sender error:(NSString *)errorMessage;
- (void)syncFinished:(id)sender;
@end

@interface Sync : NSObject <WebServiceDelegate> {
	id<SyncDelegate> delegate;
	WebService *webService;
    BOOL xmlErrorOccured;
}

@property (assign) id<SyncDelegate> delegate;
@property (nonatomic, retain) WebService *webService;
@property BOOL xmlErrorOccured;

- (void)startSync;
- (void)finishSync;

@end
