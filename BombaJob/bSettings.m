//
//  bSettings.m
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import "bSettings.h"
#import "Reachability.h"

@implementation bSettings

@synthesize inDebugMode, shouldRotate, ServicesURL;

SYNTHESIZE_SINGLETON_FOR_CLASS(bSettings);

- (void)LogThis:(NSString *)log, ... {
	if (self.inDebugMode) {
		NSString *output;
		va_list ap;
		va_start(ap, log);
		output = [[NSString alloc] initWithFormat:log arguments:ap];
		va_end(ap);
		NSLog(@"[_____BombaJob-DEBUG] : %@", output);
	}
}

- (BOOL)connectedToInternet {
	Reachability *r = [Reachability reachabilityForInternetConnection];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL result = FALSE;
	if (internetStatus == ReachableViaWiFi || internetStatus == ReachableViaWWAN)
	    result = TRUE;
	return result;
}

- (id) init {
	if (self = [super init]) {
#if TARGET_IPHONE_SIMULATOR
		self.inDebugMode = YES;
#else
		self.inDebugMode = FALSE;
#endif
        self.shouldRotate = YES;
        self.ServicesURL = @"http://www.bombajob.bg/_mob_service.php";
	}
	return self;
}

#pragma mark -
#pragma mark Helpers

- (BOOL)validEmail:(NSString *)email sitrictly:(BOOL)stricterFilter {
	// stricterFilter - Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
	NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}

- (NSString *)stripHTMLtags:(NSString *)txt {
	NSRange r;
	while ((r = [txt rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
		txt = [txt stringByReplacingCharactersInRange:r withString:@""];
	return txt;
}

@end
