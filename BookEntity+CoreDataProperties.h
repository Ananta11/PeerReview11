//
//  BookEntity+CoreDataProperties.h
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 15/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//
//

#import "BookEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BookEntity (CoreDataProperties)

+ (NSFetchRequest<BookEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *authorName;
@property (nullable, nonatomic, copy) NSString *bookName;
@property (nullable, nonatomic, copy) NSString *bookDescrpition;
@property (nonatomic) int64_t pagesRead;
@property (nonatomic) int64_t totalPages;

@end

NS_ASSUME_NONNULL_END
