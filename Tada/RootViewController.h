//
//  ViewController.h
//  Tada
//
//  Created by Ed on 2014/12/12.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController<UIScrollViewDelegate>{


    Config *config;


}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;



@end

