//
//  MyUITableViewCell.h
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHandlesMOC.h"
#import "ASHandleBooks.h"
#import "BookEntity+CoreDataClass.h"

@interface MyUITableViewCell : UITableViewCell <ASHandlesMOC, ASHandleBooks>

@property (weak, nonatomic) IBOutlet UILabel *BookNameField;
@property (weak, nonatomic) IBOutlet UILabel *TotalPagesField;
@property (strong, nonatomic) BookEntity * localBook;
@property (weak, nonatomic) IBOutlet UIProgressView *Progress;

-(void) setInternalValues:(BookEntity *) Book;
@end
