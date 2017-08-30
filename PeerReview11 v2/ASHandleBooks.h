//
//  ASHandleBooks.h
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity+CoreDataClass.h"
@protocol ASHandleBooks <NSObject>

-(void) receiveBook:(BookEntity *) Book;

@end
