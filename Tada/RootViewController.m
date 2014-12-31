//
//  ViewController.m
//  Tada
//
//  Created by Ed on 2014/12/12.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


@synthesize pageControl;
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    config = [Config sharedInstance];

    
    
    [[TadaGATracker sharedTracker] trackMyPage:@"Oi_Luanch_View"];

    if (config.isLogged) {
        //show message input  page
        
        
        

        
        
    }else{
        //show intro scrollview
        
        
        [self setIntroScrollView];
        
        
    }
    
    
}




-(void)setIntroScrollView
{
    
    [scrollView setPagingEnabled:YES];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setDelegate:self];
    
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Intro1"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Intro2"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Intro3"]];
    
    
    pageControl.hidden = NO;
    
    [self.view bringSubviewToFront:pageControl];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    if (config.isLogged) {
        //show message input  page
        
        
        
    }else{
        for (int i =0; i < (int)[self.childViewControllers count]; i++) {
            [self loadScrollViewWithPage:i];
        }
        
        self.pageControl.currentPage = 0;
        [self.pageControl setNumberOfPages:[self.childViewControllers count]];
        
        UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        if (viewController.view.superview != nil) {
            [viewController viewWillAppear:animated];
        }
        
        self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.childViewControllers count], scrollView.frame.size.height);
        
        
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    if (config.isLogged) {
        //show message input  page
        
        [self performSegueWithIdentifier:@"orderVC" sender:self];

        
    }else{
        
        
        if ([self.childViewControllers count]) {
            UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
            if (viewController.view.superview != nil) {
                [viewController viewDidAppear:animated];
            }
        }
        
        
    }
    
    
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
    // replace the placeholder if necessary
    UIViewController *controller = [self.childViewControllers objectAtIndex:page];
    if (controller == nil) {
        return;
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}




#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.pageControl.currentPage != page) {
        UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        UIViewController *newViewController = [self.childViewControllers objectAtIndex:page];
        [oldViewController viewWillDisappear:YES];
        [newViewController viewWillAppear:YES];
        self.pageControl.currentPage = page;
        [oldViewController viewDidDisappear:YES];
        [newViewController viewDidAppear:YES];
    }
}



#pragma mark - Orientations


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)termsAction:(id)sender {
}
- (IBAction)policyAction:(id)sender {
}
- (IBAction)start:(id)sender {
}
@end
