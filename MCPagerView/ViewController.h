//
//  ViewController.h
//  MCPagerView
//
//  Created by Baglan on 7/20/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPagerView.h"

@interface ViewController : UIViewController <UIScrollViewDelegate, MCPagerViewDelegate> {
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet MCPagerView *pagerView;
}

@end
