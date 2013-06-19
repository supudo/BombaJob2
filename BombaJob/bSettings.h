//
//  bSettings.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface bSettings : NSObject {
	BOOL inDebugMode, shouldRotate;
	NSString *ServicesURL;
}

@property BOOL inDebugMode, shouldRotate;
@property (nonatomic, retain) NSString *ServicesURL;

- (void)LogThis:(NSString *)log, ...;
- (BOOL)connectedToInternet;
- (BOOL)validEmail:(NSString *)email sitrictly:(BOOL)stricterFilter;
- (NSString *)stripHTMLtags:(NSString *)txt;
- (NSString *)getOfferDate:(NSDate *)offerDate;

+ (bSettings *)sharedbSettings;

@end
