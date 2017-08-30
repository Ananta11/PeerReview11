//
//  BookEntity+CoreDataProperties.m
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 15/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//
//

#import "BookEntity+CoreDataProperties.h"

@implementation BookEntity (CoreDataProperties)

+ (NSFetchRequest<BookEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BookEntity"];
}

@dynamic authorName;
@dynamic bookName;
@dynamic bookDescrpition;
@dynamic pagesRead;
@dynamic totalPages;

@end
