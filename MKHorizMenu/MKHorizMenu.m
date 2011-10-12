//
//  MKHorizMenu.m
//  MKHorizMenuDemo
//  Created by Mugunth on 09/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8h on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import "MKHorizMenu.h"
#define kButtonBaseTag 10000

@implementation MKHorizMenu

@synthesize titles = _titles;
@synthesize selectedImage = _selectedImage;

@synthesize itemSelectedDelegate;
@synthesize dataSource;
@synthesize itemCount = _itemCount;
@synthesize seperatorPadding = _seperatorPadding;
@synthesize itemPadding = _itemPadding;
@synthesize font = _font;

-(void) awakeFromNib
{
    self.bounces = YES;
    self.scrollEnabled = YES;
    self.alwaysBounceHorizontal = YES;
    self.alwaysBounceVertical = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self reloadData];
}
     
-(void) reloadData
{
    for (UIView *view in self.subviews) 
    {
        [view removeFromSuperview];
    }
    
    [self.titles release];
    self.titles = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.itemCount = [dataSource numberOfItemsForMenu:self];
    self.backgroundColor = [dataSource backgroundColorForMenu:self];
//    self.selectedImage = [dataSource selectedItemImageForMenu:self];
    
    if ([dataSource respondsToSelector:@selector(seperatorPaddingForMenu:)]) 
        self.seperatorPadding = [dataSource seperatorPaddingForMenu:self];
    else
        self.seperatorPadding = 10;

    if ([dataSource respondsToSelector:@selector(itemPaddingForMenu:)]) 
        self.itemPadding = [dataSource itemPaddingForMenu:self];
    else
        self.itemPadding = 10;

//    if ([dataSource respondsToSelector:@selector(fontForMenu:)]) 
//        self.font = [dataSource fontForMenu:self];
//    else
//        self.font = [UIFont boldSystemFontOfSize:15];
        
    int tag = kButtonBaseTag;    
    int xPos = 10;//self.seperatorPadding;

    for(int i = 0 ; i < self.itemCount; i ++)
    {       
        UIColor *seperatorColor = [UIColor blackColor];
        
        if([dataSource respondsToSelector:@selector(seperatorColorForMenu:)])
            seperatorColor = [dataSource seperatorColorForMenu:self];
        
        UIButton *customButton;
        
        if ([dataSource respondsToSelector:@selector(horizMenu:buttonForItemAtIndex:)])
            customButton = [dataSource horizMenu:self buttonForItemAtIndex:i];
        
        NSString *title = customButton.titleLabel.text;
        [self.titles addObject:title];
                       
        customButton.tag = tag++;
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [title sizeWithFont:customButton.titleLabel.font
                            constrainedToSize:CGSizeMake(320, self.bounds.size.height-7*2) 
                                lineBreakMode:UILineBreakModeClip].width;
        
        customButton.frame = CGRectMake(xPos, 7, buttonWidth + self.itemPadding, self.bounds.size.height-7*2);
        xPos += buttonWidth;
        xPos += self.itemPadding;
        [self addSubview:customButton];        
        
        if (i < self.itemCount-1) 
        {
            UILabel *seperatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 7, self.seperatorPadding, self.bounds.size.height-7*2)];
            seperatorLabel.textAlignment = UITextAlignmentCenter;
            seperatorLabel.font = self.font;
            seperatorLabel.text = @"•";
            seperatorLabel.textColor = seperatorColor;
            seperatorLabel.backgroundColor = [UIColor clearColor];
            seperatorLabel.opaque = YES;
            [self addSubview:seperatorLabel];
            xPos += self.seperatorPadding;
        }
    }
    self.contentSize = CGSizeMake(xPos+10, self.bounds.size.height);    
    [self layoutSubviews];
}


-(void) setSelectedIndex:(int) index animated:(BOOL) animated
{
    UIButton *thisButton = (UIButton*) [self viewWithTag:index + kButtonBaseTag];    
    thisButton.selected = YES;
    [self setContentOffset:CGPointMake(thisButton.frame.origin.x - self.seperatorPadding, 0) animated:animated];
    [self.itemSelectedDelegate horizMenu:self itemSelectedAtIndex:index];
}

-(void) buttonTapped:(id) sender
{
    UIButton *button = (UIButton*) sender;
    
    for(int i = 0; i < self.itemCount; i++)
    {
        UIButton *thisButton = (UIButton*) [self viewWithTag:i + kButtonBaseTag];
        if(i + kButtonBaseTag == button.tag)
            thisButton.selected = YES;
        else
            thisButton.selected = NO;
    }
    
    [self.itemSelectedDelegate horizMenu:self itemSelectedAtIndex:button.tag - kButtonBaseTag];
}


- (void)dealloc
{
    [_selectedImage release];
    _selectedImage = nil;
    [_titles release];
    _titles = nil;
    [_font release];
    _font = nil;
    
    [super dealloc];
}

@end
