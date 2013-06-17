//
//  DBManagedObjectContext.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManagedObjectContext : NSObject {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DBManagedObjectContext *)sharedDBManagedObjectContext;

- (NSManagedObject *)getEntity:(NSString *)entityName predicateString:(NSString *)predicateString;
- (NSManagedObject *)getEntity:(NSString *)entityName predicate:(NSPredicate *)predicate;
- (NSArray *)getEntities:(NSString *)entityName predicate:(NSPredicate *)predicate;
- (NSArray *)getEntities:(NSString *)entityName predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)getEntities:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)getEntities:(NSString *)entityName;
- (int)getEntitiesCount:(NSString *)entityName;
- (int)getEntitiesCount:(NSString *)entityName predicate:(NSPredicate *)predicate;
- (BOOL) deleteAllObjects:(NSString *)entityName;
- (BOOL) deleteObjects:(NSString *)entityName predicate:(NSPredicate *)predicate;

- (NSString *)applicationDocumentsDirectory;

@end
