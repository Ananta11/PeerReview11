//
//  ASHandlesMOC.h
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CoreData/CoreData.h"
@protocol ASHandlesMOC <NSObject>

-(void) receiveMOC:(NSManagedObjectContext *) managedObjectContext;

@end
