//
//  MyUITableViewController.h
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHandlesMOC.h"
#import "ASHandleBooks.h"
#import "CoreData/CoreData.h"
#import "BookEntity+CoreDataClass.h"
#import "MyUITableViewCell.h"

@interface MyUITableViewController : UITableViewController <ASHandlesMOC>
@property (weak, nonatomic) IBOutlet UILabel *FinalCellText;
@property (weak, nonatomic) IBOutlet UIView *FooterView;

-(void) receiveMOC:(NSManagedObjectContext *)managedObjectContext;

@end
