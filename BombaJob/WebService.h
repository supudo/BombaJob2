//
//  WebService.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLReader.h"
#import "dbCategory.h"
#import "dbJobOffer.h"
#import "dbTextContent.h"
#import "dbSettings.h"

@protocol WebServiceDelegate <NSObject>
@optional
- (void)serviceError:(id)sender error:(NSString *)errorMessage;
- (void)tokenSent:(id)sender;
- (void)postJobFinished:(id)sender;
- (void)postMessageFinished:(id)sender;
- (void)getCategoriesFinished:(id)sender;
- (void)getNewJobsFinished:(id)sender;
- (void)getJobsHumanFinished:(id)sender;
- (void)getJobsCompanyFinished:(id)sender;
- (void)getTextContentFinished:(id)sender;
- (void)searchOffersFinished:(id)sender;
- (void)geoSearchOffersFinished:(id)sender;
- (void)sendEmailMessageFinished:(id)sender;
- (void)configFinshed:(id)sender;
@end

@interface WebService : NSObject <NSXMLParserDelegate, URLReaderDelegate> {
	id<WebServiceDelegate> delegate;
	URLReader *urlReader;
	NSManagedObjectContext *managedObjectContext;
	NSString *currentElement;
	int OperationID;
	dbCategory *entCategory;
	dbJobOffer *entOffer;
	dbTextContent *entTextContent;
    dbSettings *entSetting;
}

@property (assign) id<WebServiceDelegate> delegate;
@property (nonatomic, retain) URLReader *urlReader;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property int OperationID;
@property (nonatomic, retain) dbCategory *entCategory;
@property (nonatomic, retain) dbJobOffer *entOffer;
@property (nonatomic, retain) dbTextContent *entTextContent;
@property (nonatomic, retain) dbSettings *entSetting;

typedef enum NLServiceOperations {
    NLOperationAPNS = 0,
	NLOperationPostJob,
	NLOperationPostMessage,
	NLOperationGetCategories,
	NLOperationGetNewJobs,
	NLOperationGetJobsHuman,
	NLOperationGetJobsCompany,
	NLOperationGetTextContents,
	NLOperationSearch,
	NLOperationSearchGeo,
	NLOperationSendEmail,
	NLOperationConfigs
} NLServiceOperations;

- (void)getConfiguration;
- (void)postNewJob;
- (void)postMessage:(int)offerID message:(NSString *)msg;
- (void)getCategories;
- (void)getNewJobs;
- (void)searchJobs;
- (void)searchPeople;
- (void)getTextContent;
- (void)searchOffers:(NSString *)searchTerm freelance:(BOOL)frl;
- (void)sendEmailMessage:(int)offerID toEmail:(NSString *)toEmail fromEmail:(NSString *)fromEmail;

@end