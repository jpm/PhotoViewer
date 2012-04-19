//
//  EGOThumbsScrollView.h
//  EGOPhotoViewer
//
//  Created by Henrik Nyh on 2010-06-25.
//  Copyright 2010 Henrik Nyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOPhotoSource.h"
@class EGOThumbsViewController;

@interface EGOThumbsScrollView : UIScrollView {
	EGOPhotoSource *photoSource;
	EGOThumbsViewController *controller;
	UIInterfaceOrientation laidOutForOrientation;
    BOOL editing;
}

@property(nonatomic, retain) EGOPhotoSource *photoSource;
@property(nonatomic,assign) EGOThumbsViewController *controller;
@property(nonatomic,assign) BOOL editing;

- (void)setEditing:(BOOL)newEditing;

@end
