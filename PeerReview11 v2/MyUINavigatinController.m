//
//  MyUINavigatinController.m
//  PeerReview11 v2
//
//  Created by Ananta Shahane on 14/08/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import "MyUINavigatinController.h"


@interface MyUINavigatinController ()

@property (nonatomic, strong) NSManagedObjectContext *localManagedObjectContext;

@end

@implementation MyUINavigatinController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [[UIImage imageNamed:@"leather"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
    
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

-(void) receiveMOC:(NSManagedObjectContext *)managedObjectContext
{
    self.localManagedObjectContext = managedObjectContext;
    id<ASHandlesMOC> child = (id<ASHandlesMOC>) self.viewControllers[0];
    [child receiveMOC:managedObjectContext];
}


@end
