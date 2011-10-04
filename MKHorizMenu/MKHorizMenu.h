//
//  MKHorizMenu.h
//  MKHorizMenuDemo
//
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

#import <UIKit/UIKit.h>

@class MKHorizMenu;

@protocol MKHorizMenuDataSource <NSObject>
@optional
- (UIColor*) horizMenu:(MKHorizMenu*) horizMenu textColorForItemAtIndex:(NSUInteger) index;
- (UIColor*) horizMenu:(MKHorizMenu*) horizMenu selectedColorForItemAtIndex:(NSUInteger) index;
- (int) seperatorPaddingForMenu:(MKHorizMenu*) tabView;
- (int) itemPaddingForMenu:(MKHorizMenu*) tabView;
- (UIFont*) fontForMenu:(MKHorizMenu*) tabView;
@required
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabView;
- (UIColor*) backgroundColorForMenu:(MKHorizMenu*) tabView;
- (int) numberOfItemsForMenu:(MKHorizMenu*) tabView;

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu titleForItemAtIndex:(NSUInteger) index;
@end

@protocol MKHorizMenuDelegate <NSObject>
@required
- (void)horizMenu:(MKHorizMenu*) horizMenu itemSelectedAtIndex:(NSUInteger) index;
@end

@interface MKHorizMenu : UIScrollView {

    int _itemCount;
    int _seperatorPadding;
    int _itemPadding;
    UIImage *_selectedImage;
    UIFont  *_font;
    NSMutableArray *_titles;
    id <MKHorizMenuDataSource> dataSource;
    id <MKHorizMenuDelegate> itemSelectedDelegate;
}

@property (nonatomic, retain) NSMutableArray *titles;
@property (nonatomic, assign) IBOutlet id <MKHorizMenuDelegate> itemSelectedDelegate;
@property (nonatomic, retain) IBOutlet id <MKHorizMenuDataSource> dataSource;

@property (nonatomic, assign) int itemCount;

@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, assign) int seperatorPadding;
@property (nonatomic, assign) int itemPadding;
@property (nonatomic, retain) UIFont *font;


-(void) reloadData;
-(void) setSelectedIndex:(int) index animated:(BOOL) animated;
@end
