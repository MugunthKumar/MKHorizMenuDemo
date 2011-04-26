//
//  HorizontalTabView.h
//  ISIZLBrowser
//
//  Created by Mugunth on 23/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKHorizMenu;

@protocol MKHorizMenuDataSource <NSObject>
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
    UIImage *_selectedImage;
    id <MKHorizMenuDataSource> dataSource;
    id <MKHorizMenuDelegate> itemSelectedDelegate;
}

@property (nonatomic, retain) NSMutableArray *titles;
@property (nonatomic, assign) IBOutlet id <MKHorizMenuDelegate> itemSelectedDelegate;
@property (nonatomic, retain) IBOutlet id <MKHorizMenuDataSource> dataSource;
@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, assign) int itemCount;

-(void) reloadData;
-(void) setSelectedIndex:(int) index animated:(BOOL) animated;
@end
