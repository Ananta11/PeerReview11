//
//  MyUIViewController.h
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHandleBooks.h"
#import "ASHandlesMOC.h"
@interface MyUIViewController : UIViewController<ASHandlesMOC, ASHandleBooks>

-(void) receiveMOC:(NSManagedObjectContext *)managedObjectContext;
-(void) receiveBook:(BookEntity *)Book;


@end
