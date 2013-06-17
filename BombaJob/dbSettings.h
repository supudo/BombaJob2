//
//  dbSettings.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface dbSettings : NSManagedObject

@property (nonatomic, retain) NSString * sName;
@property (nonatomic, retain) NSString * sValue;

@end
