//
//  ViewController.m
//  MCPagerView
//
//  Created by Baglan on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Scroll view
    for (int i=0; i<6; i++) {
        CGRect frame = CGRectMake(scrollView.frame.size.width * i,
                                  0,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:144.0];
        label.text = [NSString stringWithFormat:@"%d", i];
        
        [scrollView addSubview:label];
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 6, scrollView.frame.size.height);
    
    scrollView.delegate = self;
    
    // Pager
    [pagerView setImage:[UIImage imageNamed:@"a"]
       highlightedImage:[UIImage imageNamed:@"a-h"]
                 forKey:@"a"];
    [pagerView setImage:[UIImage imageNamed:@"b"]
       highlightedImage:[UIImage imageNamed:@"b-h"]
                 forKey:@"b"];
    [pagerView setImage:[UIImage imageNamed:@"c"]
       highlightedImage:[UIImage imageNamed:@"c-h"]
                 forKey:@"c"];
    
    [pagerView setPattern:@"abcabc"];
    
    pagerView.delegate = self;
}

- (void)updatePager
{
    pagerView.page = floorf(scrollView.contentOffset.x / scrollView.frame.size.width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePager];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self updatePager];
    }
}

- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage
{
    CGPoint offset = CGPointMake(scrollView.frame.size.width * pagerView.page, 0);
    [scrollView setContentOffset:offset animated:YES];
}

- (void)viewDidUnload
{
    pagerView = nil;
    scrollView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
