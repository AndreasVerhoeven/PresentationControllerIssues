//
//  PopupViewController.m
//  PresentationTest
//
//  Created by Andreas Verhoeven on 06-03-15.
//

#import "PopupViewController.h"
#import "PresentationController.h"

@interface PopupViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation PopupViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self != nil)
    {
        self.transitioningDelegate = self;
        self.view.backgroundColor = [UIColor greenColor];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.preferredContentSize = CGSizeMake(200, 320);
    }
    
    return self;
}

-(UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Show fullscreen VC" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentIt:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    button.center = self.view.center;
    [self.view addSubview:button];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentIt:)]];
}

-(void)presentIt:(id)sender
{
    UIViewController* vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissPresented:)];
    UINavigationController* navVc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVc animated:YES completion:nil];
}

-(void)dismissPresented:(id)sender
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
