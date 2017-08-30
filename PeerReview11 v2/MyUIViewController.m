//
//  MyUIViewController.m
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import "MyUIViewController.h"

@interface MyUIViewController ()
@property (weak, nonatomic) IBOutlet UITextField *BookNameField;
@property (weak, nonatomic) IBOutlet UITextField *AuthorNameField;
@property (weak, nonatomic) IBOutlet UITextField *TotalPagesField;
@property (weak, nonatomic) IBOutlet UILabel *PagesTodayField;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *CompletionField;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressBar;
@property (strong, nonatomic) NSManagedObjectContext *localManagedObjectContext;
@property (strong, nonatomic) BookEntity *localBook;
@property (nonatomic) float progress;
@property (weak, nonatomic) IBOutlet UIStepper *Stepper;
@property (nonatomic) long long currentPage;


@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNotificationCenter *ctr = [NSNotificationCenter defaultCenter];
    [ctr addObserver:self
            selector:@selector(keyBoardDidShow:)
                name:UIKeyboardWillShowNotification
              object:nil];
    
    [ctr addObserver:self
            selector:@selector(keyBoardDidHide:)
                name:UIKeyboardWillHideNotification
              object:nil];
    [self.ProgressBar setProgress:self.progress animated:YES];
    self.Stepper.minimumValue = 0;
    self.Stepper.maximumValue = self.localBook.totalPages;
    self.Stepper.value = self.localBook.pagesRead;
    self.currentPage = self.localBook.pagesRead;
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.62 alpha:1.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BookNameEdited:(id)sender {
    self.localBook.bookName = self.BookNameField.text;
    [self saveData];
}

- (IBAction)AuthorNameDidEdit:(id)sender {
    self.localBook.authorName = self.AuthorNameField.text;
    [self saveData];
}

- (IBAction)TotalPagesEdited:(id)sender {
    self.localBook.totalPages = [self.TotalPagesField.text integerValue];
    [self saveData];
}

- (IBAction)ReadChanged:(UIStepper *)sender {
    double deltapage = self.Stepper.value-self.currentPage;
    self.PagesTodayField.text = [NSString stringWithFormat:@"%.0f", deltapage];
    self.localBook.pagesRead = self.Stepper.value;
    [self saveData];
    [self updateProgress];
}




-(void) receiveBook:(BookEntity *)Book{
    self.localBook = Book;
}

-(void) receiveMOC:(NSManagedObjectContext *)managedObjectContext{
    self.localManagedObjectContext = managedObjectContext;
}

-(void) saveData
{
    if([self.BookNameField.text compare:@""] != 0)
    {
        NSError *error = nil;
        BOOL saveSucceed = [self.localManagedObjectContext save:&error];
        if(!saveSucceed)
        {
            @throw [NSException exceptionWithName:NSGenericException reason:@"Can't save data.\n" userInfo:@{NSUnderlyingErrorKey: error}];
        }
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    if(self.localBook.bookName == nil)
    {
        self.navigationItem.title = @"Add a book.";
        self.CompletionField.text = @"No Data yet";
    }
    else
    {
        self.navigationItem.title = [NSString stringWithFormat:@"Edit %@",self.localBook.bookName];
        
        self.progress = (float)self.localBook.pagesRead/self.localBook.totalPages;
        [self updateProgress];
    }
    self.BookNameField.text = self.localBook.bookName;
    self.AuthorNameField.text = self.localBook.authorName;
    self.TotalPagesField.text = [NSString stringWithFormat:@"%lld",self.localBook.totalPages];
    self.DescriptionField.text = self.localBook.bookDescrpition;
}


-(void) textViewDidEndEditing: (NSNotification *) notification
{
    if([notification object] == self)
    {
        self.localBook.bookDescrpition = self.DescriptionField.text;
        [self saveData];
    }
}

-(void) updateProgress
{
    self.CompletionField.text = [NSString stringWithFormat:@"%lld/%lld pages. %.2f%% completed.",self.localBook.pagesRead, self.localBook.totalPages, self.progress*100];
    self.progress = (float) self.localBook.pagesRead/self.localBook.totalPages;
    [self.ProgressBar setProgress:self.progress animated:YES];
}

- (IBAction)DeleteTapped:(id)sender
{
    [self.localManagedObjectContext deleteObject:self.localBook];
    [self saveData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.BookNameField.text compare:@""] == 0)
    {
        [self.localManagedObjectContext deleteObject:self.localBook];
    }
    self.localBook.bookDescrpition = self.DescriptionField.text;
    [self saveData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
}
@end
