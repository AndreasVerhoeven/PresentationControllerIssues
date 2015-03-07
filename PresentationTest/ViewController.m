//
//  ViewController.m
//  PresentationTest
//
//  Created by Andreas Verhoeven on 06-03-15.
//

#import "ViewController.h"
#import "PopupViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Present me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentIt:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    button.center = self.view.center;
    [self.view addSubview:button];
}

-(void)presentIt:(id)sender
{
    PopupViewController* vc = [PopupViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
