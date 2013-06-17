//
//  dbJobOffer.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class dbCategory;

@interface dbJobOffer : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * categoryTitle;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * freelanceYn;
@property (nonatomic, retain) NSNumber * humanYn;
@property (nonatomic, retain) NSString * negativism;
@property (nonatomic, retain) NSNumber * offerID;
@property (nonatomic, retain) NSString * positivism;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSNumber * readYn;
@property (nonatomic, retain) NSNumber * sentMessageYn;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) dbCategory *category;

@end
