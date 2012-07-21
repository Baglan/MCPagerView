# MCPagerView

## Project goal

Make a replacement for the UIPageControl, with a similar functionality but custom "dots".

Here is a screenshot from the sample project:

![Sample project screenshot](https://github.com/Baglan/MCPagerView/raw/master/MCPagerView.png)

## License

This code is available under the MIT license.

## Installation

1. Drag files from the Classes folder to your project;
2. \#import "MCPagerView.h" wherever you want to use it.

## Usage

Initialize the MCPagerView as you would do with any other view: either add a view in the Interface Builder and set a "MCPagerView" class on it or create one programmatically with a code like this:

	[MCPagerView alloc] initWithFrame:CGRectMake(0,0,6*44,44)];

Actual values will depend on the sizes and the number of  "dots".

Set the "pattern". Number of characters in the pattern will determine the number of pages and what kind of "dot" will be used for each of them. Here is the example from the sample project:

	[pagerView setPattern:@"abcabc"];

This pager will have 6 pages with dot types "a", "b" and "c".

Now images should be specied for each of the dot types:

    [pagerView setImage:[UIImage imageNamed:@"a"]
       highlightedImage:[UIImage imageNamed:@"a-h"]
                 forKey:@"a"];

In this example, dot "a" is set up with "a.png" as the default value and "a-h.png" as a "highlighted" value. Dot is highlighted when it corresponds to the current "page" property.

Current page can be read or set by accessing the "page" property:

	pagerView.page = 3;

A delegate can be set to receive updates to the pager:

	pagerView.delegate = self;

Delegate should implement the "MCPagerViewDelegate" protocol. This protocol has two optional methods:

	- (BOOL)pageView:(MCPagerView *)pageView shouldUpdateToPage:(NSInteger)newPage;
	- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage;

Here is a simple "go to page" code from the sample project:

	- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage
	{
	    CGPoint offset = CGPointMake(scrollView.frame.size.width * pagerView.page, 0);
	    [scrollView setContentOffset:offset animated:YES];
	}

Alternatively, an object can observe the "MCPAGERVIEW_DID_UPDATE_NOTIFICTAION" notification on the default notification center:

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPageChange)
                                                 name:MCPAGERVIEW_DID_UPDATE_NOTIFICTAION
                                               object:pagerView];