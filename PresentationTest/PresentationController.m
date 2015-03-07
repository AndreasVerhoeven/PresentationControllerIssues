//
//  AvePresentationController.m
//  PresentationTest
//
//  Created by Andreas Verhoeven on 06-03-15.
//

#import "PresentationController.h"

#define USE_DIMMING_VIEW // disabling this will make the presentation not be animated
#define USE_WRAPPER_PRESENTED_VIEW // disabling this will cause the 'fullscreen dismissal' issue, enabling this will make black borders show up during rotation

@implementation PresentationController
{
    UIView* _dimmingView;
    UIView* _presentedView;
}

-(id)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if(self != nil)
    {
#ifdef USE_DIMMING_VIEW
        _dimmingView = [UIView new];
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [_dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPresentedViewController)]];
#endif
    }
    
    return self;
}

-(void)dismissPresentedViewController
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#ifdef USE_WRAPPER_PRESENTED_VIEW
-(UIView*)presentedView
{
    if(nil == _presentedView)
    {
        _presentedView = [UIView new];
        [_presentedView addSubview:[super presentedView]];
        [self.containerView addSubview:_presentedView];
    }
    return _presentedView;
}
#endif

-(void)presentationTransitionWillBegin
{
    if(_dimmingView != nil)
    {
        [self.containerView addSubview:_dimmingView];
        
        _dimmingView.alpha = 0;
        [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>context){
            _dimmingView.alpha = 1;
        } completion:nil];
    }
}

-(void)presentationTransitionDidEnd:(BOOL)completed
{
    if(!completed)
    {
        [_dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin
{
    if(_dimmingView != nil)
    {
        [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>context){
            _dimmingView.alpha = 0;
        } completion:nil];
    }
}

-(CGRect)frameOfPresentedViewInContainerView
{
    CGSize preferredContentSize = [self.presentedViewController preferredContentSize];
    preferredContentSize.height = MIN(self.containerView.bounds.size.height, preferredContentSize.height);
    
    CGRect presentedViewFrame = self.containerView.bounds;
    presentedViewFrame.origin.y = presentedViewFrame.size.height - preferredContentSize.height;
    presentedViewFrame.size.height = preferredContentSize.height;
    return presentedViewFrame;
}

- (void)containerViewDidLayoutSubviews
{
    _dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
#ifdef USE_WRAPPER_PRESENTED_VIEW
    [super presentedView].frame = self.presentedView.bounds;
#endif
}


@end
