//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;


- (void)viewDidLoad
{
    self.items = [NSArray arrayWithObjects:@"Headlines", @"UK", @"International", @"Politics", @"Weather", @"Travel", @"Radio", @"Hollywood", @"Sports", @"Others", nil];    
    [self.horizMenu reloadData];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.selectionItemLabel = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:5 animated:YES];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark HorizMenu Data Source

-(UIButton *)horizMenu:(MKHorizMenu *)horizMenu buttonForItemAtIndex:(NSUInteger)index
{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = [self.items objectAtIndex:index];
    UIColor  *textColorForButton = [UIColor whiteColor];
    UIColor  *selectedTextColorForButton = [UIColor whiteColor];
    
    if (index == 4) 
        textColorForButton = [UIColor magentaColor];
    
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:textColorForButton forState:UIControlStateNormal];
    [customButton setTitleColor:selectedTextColorForButton forState:UIControlStateSelected];
    customButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];

    return customButton;
}

-(UIColor *)seperatorColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor whiteColor];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    return [self.items count];
}

- (int) itemPaddingForMenu:(MKHorizMenu *)tabView
{
    return 0;
}

- (int)seperatorPaddingForMenu:(MKHorizMenu *)tabView
{
    return 25;
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{        
    self.selectionItemLabel.text = [self.items objectAtIndex:index];
}
@end
