//
//  OfferDetails.h
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dbJobOffer.h"

@interface OfferDetails : UIViewController {
    dbJobOffer *currentOffer;
}

@property (strong) dbJobOffer *currentOffer;

@end
