//
//  EGOThumbsViewController.h
//  EGOPhotoViewer
//
//  Created by Henrik Nyh on 2010-06-25.
//  Copyright 2010 Henrik Nyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOPhotoSource.h"
#import "EGOThumbsScrollView.h"
#import "EGOStoredBarStyles.h"


@protocol EGOThumbsViewControllerDelegate <NSObject>

- (void)egoThumbsViewController:(EGOThumbsViewController *)controller didDeleteThumbAtIndex:(NSInteger)index;

@end


@interface EGOThumbsViewController : UIViewController {
	EGOPhotoSource *_photoSource;
	EGOThumbsScrollView *_scrollView;
	EGOStoredBarStyles *storedStyles;
    
    id<EGOThumbsViewControllerDelegate> delegate;
}

- (id)initWithPhotoSource:(EGOPhotoSource*)aSource withEditingEnabled:(BOOL)enabled;
- (id)initWithPhotoSource:(EGOPhotoSource*)aSource;
- (void)didSelectThumbAtIndex:(NSInteger)index;
- (void)didSelectThumbAtIndexToDelete:(NSInteger)index;

@property(nonatomic,readonly) EGOPhotoSource *photoSource;
@property(nonatomic, retain) EGOStoredBarStyles *storedStyles;
@property(nonatomic, assign) id<EGOThumbsViewControllerDelegate> delegate;

@end
