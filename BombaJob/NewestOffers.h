//
//  NewestOffers.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"

@interface NewestOffers : UITableViewController <WebServiceDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@end
