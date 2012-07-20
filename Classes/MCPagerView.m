//
//  MCPagerView.m
//  MCPagerView
//
//  Created by Baglan on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MCPagerView.h"

@implementation MCPagerView {
    NSMutableDictionary *_images;
    NSMutableArray *_pageViews;
}

@synthesize page = _page;
@synthesize pattern = _pattern;
@synthesize delegate = _delegate;

- (void)commonInit
{
    _page = 0;
    _pattern = @"";
    _images = [NSMutableDictionary dictionary];
    _pageViews = [NSMutableArray array];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setPage:(NSInteger)page
{
    // Skip if delegate said "do not update"
    if ([_delegate respondsToSelector:@selector(pageView:shouldUpdateToPage:)] && ![_delegate pageView:self shouldUpdateToPage:page]) {
        return;
    }
    
    _page = page;
    [self setNeedsLayout];
    
    // Inform delegate of the update
    if ([_delegate respondsToSelector:@selector(pageView:didUpdateToPage:)]) {
        [_delegate pageView:self didUpdateToPage:page];
    }
    
    // Send update notification
    [[NSNotificationCenter defaultCenter] postNotificationName:MCPAGERVIEW_DID_UPDATE_NOTIFICTAION object:self];
}

- (NSInteger)numberOfPages
{
    return _pattern.length;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer
{
    self.page = [_pageViews indexOfObject:recognizer.view];
}

- (void)layoutSubviews
{
    [_pageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        [view removeFromSuperview];
    }];
    [_pageViews removeAllObjects];
    
    NSInteger pages = self.numberOfPages;
    CGFloat xOffset = 0;
    for (int i=0; i<pages; i++) {
        NSString *key = [_pattern substringWithRange:NSMakeRange(i, 1)];
        UIImageView *sourceImageView = [_images objectForKey:key];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:sourceImageView.image highlightedImage:sourceImageView.highlightedImage];
        CGRect frame = imageView.frame;
        frame.origin.x = xOffset;
        imageView.frame = frame;
        imageView.highlighted = (i == self.page);
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [imageView addGestureRecognizer:tgr];
        
        [self addSubview:imageView];
        
        [_pageViews addObject:imageView];
        
        
        
        xOffset = xOffset + frame.size.width;
    }
}

- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage forKey:(NSString *)key
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image highlightedImage:highlightedImage];
    [_images setObject:imageView forKey:key];
    [self setNeedsLayout];
}

@end
