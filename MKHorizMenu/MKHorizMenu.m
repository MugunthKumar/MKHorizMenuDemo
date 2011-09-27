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
#define kLeftOffset 10

@implementation MKHorizMenu

@synthesize titles = _titles;
@synthesize selectedImage = _selectedImage;

@synthesize itemSelectedDelegate;
@synthesize dataSource;
@synthesize itemCount = _itemCount;

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
    
    self.itemCount = [dataSource numberOfItemsForMenu:self];
    self.backgroundColor = [dataSource backgroundColorForMenu:self];
    self.selectedImage = [dataSource selectedItemImageForMenu:self];
    _textColor = _selectedTextColor = [UIColor whiteColor];
            
    if ([dataSource respondsToSelector:@selector(textColorForMenu:)]) 
        _textColor = [dataSource textColorForMenu:self];

    if ([dataSource respondsToSelector:@selector(selectedTextColorForMenu:)]) 
        _selectedTextColor = [dataSource selectedTextColorForMenu:self];
    
    UIFont *buttonFont = [UIFont boldSystemFontOfSize:15];
    int buttonPadding = 25;
    
    int tag = kButtonBaseTag;    
    int xPos = kLeftOffset;

    for(int i = 0 ; i < self.itemCount; i ++)
    {
        NSString *title = [dataSource horizMenu:self titleForItemAtIndex:i];
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setTitle:title forState:UIControlStateNormal];
        [customButton setTitleColor:_textColor forState:UIControlStateNormal];
        [customButton setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        customButton.titleLabel.font = buttonFont;
        
        [customButton setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
        
        customButton.tag = tag++;
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [title sizeWithFont:customButton.titleLabel.font
                            constrainedToSize:CGSizeMake(150, self.bounds.size.height-7*2) 
                                lineBreakMode:UILineBreakModeClip].width;
        
        customButton.frame = CGRectMake(xPos, 7, buttonWidth + buttonPadding, self.bounds.size.height-7*2);
        xPos += buttonWidth;
        xPos += buttonPadding;
        [self addSubview:customButton];        
    }
    self.contentSize = CGSizeMake(xPos, self.bounds.size.height);    
    [self layoutSubviews];  
}


-(void) setSelectedIndex:(int) index animated:(BOOL) animated
{
    UIButton *thisButton = (UIButton*) [self viewWithTag:index + kButtonBaseTag];    
    thisButton.selected = YES;
    [self setContentOffset:CGPointMake(thisButton.frame.origin.x - kLeftOffset, 0) animated:animated];
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
    
    [super dealloc];
}

@end
