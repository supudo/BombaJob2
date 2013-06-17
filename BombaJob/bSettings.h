//
//  bSettings.h
//  BombaJob
//
//  Created by supudo on 7/4/11.
//  Copyright 2011 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface bSettings : NSObject {
	BOOL inDebugMode;
	NSString *ServicesURL;
}

@property BOOL inDebugMode;
@property (nonatomic, retain) NSString *ServicesURL;

- (void)LogThis:(NSString *)log, ...;
- (BOOL)connectedToInternet;
- (BOOL)validEmail:(NSString *)email sitrictly:(BOOL)stricterFilter;
- (NSString *)stripHTMLtags:(NSString *)txt;

+ (bSettings *)sharedbSettings;

@end
