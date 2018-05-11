//
//  MyUITableViewCell.m
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import "MyUITableViewCell.h"

@implementation MyUITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setInternalValues:(BookEntity *)Book
{
    self.BookNameField.text = [NSString stringWithFormat:@"\"%@\" by %@",Book.bookName, Book.authorName];
    self.TotalPagesField.text = [NSString stringWithFormat:@"%lld pages left", Book.totalPages-Book.pagesRead];
    self.localBook = Book;
    float prog = (float)self.localBook.pagesRead/self.localBook.totalPages;
    [self.Progress setProgress:prog animated:YES];
}


@end
