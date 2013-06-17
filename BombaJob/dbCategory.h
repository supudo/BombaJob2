//
//  dbCategory.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class dbJobOffer;

@interface dbCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * categoryTitle;
@property (nonatomic, retain) NSNumber * offersCount;
@property (nonatomic, retain) NSSet *offers;
@end

@interface dbCategory (CoreDataGeneratedAccessors)

- (void)addOffersObject:(dbJobOffer *)value;
- (void)removeOffersObject:(dbJobOffer *)value;
- (void)addOffers:(NSSet *)values;
- (void)removeOffers:(NSSet *)values;

@end
