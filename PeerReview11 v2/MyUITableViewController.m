//
//  MyUITableViewController.m
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import "MyUITableViewController.h"

@interface MyUITableViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext * localManagedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController * resultsController;
@end

@implementation MyUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self NSFetchedResultsControllerDelegateController];
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.62 alpha:1.0];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Grunge-Paper-Texture-1"]];
    [tempImageView setFrame:self.tableView.frame];
    [self NotificationSquad];
    self.tableView.backgroundView = tempImageView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsController.sections[section].numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdenttifier" forIndexPath:indexPath];
    BookEntity *book = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    [cell setInternalValues:book];
    
    return cell;
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
    [self NotificationSquad];
}

-(void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:{
            MyUITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            BookEntity *book = [controller objectAtIndexPath:indexPath];
            [cell setInternalValues:book];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    id<ASHandleBooks,ASHandlesMOC> child =  (id <ASHandlesMOC,ASHandleBooks>)[segue destinationViewController];
    [child receiveMOC:self.localManagedObjectContext];
    BookEntity *book;
    if([sender isMemberOfClass:[UIBarButtonItem class]])
    {
        book = [NSEntityDescription insertNewObjectForEntityForName:@"BookEntity" inManagedObjectContext:self.localManagedObjectContext];
    }
    else
    {
        MyUITableViewCell *source = (MyUITableViewCell *)sender;
        book = source.localBook;
    }
    [child receiveBook:book];
}

-(void) NSFetchedResultsControllerDelegateController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BookEntity" inManagedObjectContext:self.localManagedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"bookName" ascending:YES]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.localManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.resultsController.delegate = self;
    
    NSError *error = nil;
    BOOL fetchSucceed = [self.resultsController performFetch:&error];
    if(!fetchSucceed)
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Can't Fetch" userInfo:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        MyUITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        BookEntity *book = cell.localBook;
        [self.localManagedObjectContext deleteObject:book];
        NSError *error = nil;
        BOOL saveSucceed = [self.localManagedObjectContext save:&error];
        if(!saveSucceed)
        {
            @throw [NSException exceptionWithName:NSGenericException reason:@"Can't save data.\n" userInfo:@{NSUnderlyingErrorKey: error}];
        }
        
    }
}

-(void) NotificationSquad
{
    long long number = self.resultsController.sections[0].numberOfObjects;
    long long total = 0;
    long long read = 0;
    if(number == 0)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    else
    {
        for (int i = 0; i < number; i++)
        {
            BookEntity *Book = self.resultsController.sections[0].objects[i];
            total += Book.totalPages;
            read += Book.pagesRead;
        }
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:total-read];
    }
    self.FinalCellText.text = [NSString stringWithFormat:@"%lld/%lld pages done. Total Progress %.2f%%", read, total, (float)read/total*100];
}

-(void) receiveMOC:(NSManagedObjectContext *)managedObjectContext
{
    self.localManagedObjectContext = managedObjectContext;
}

@end
