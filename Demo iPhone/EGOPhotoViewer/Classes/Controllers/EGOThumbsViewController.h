//
//  EGOThumbsViewController.h
//  EGOPhotoViewer
//
//  Created by Henrik Nyh on 2010-06-25.
//  Copyright 2010 Henrik Nyh. All rights reserved.
//

// TODO:
// - borders on thumbs
// - transparent bars (and restore when returning)
// - cleanup whitespace

#import <UIKit/UIKit.h>
#import "EGOPhotoSource.h"
#import "EGOThumbsScrollView.h"

@interface EGOThumbsViewController : UIViewController {
	EGOPhotoSource *_photoSource;
  EGOThumbsScrollView *_scrollView;
}

- (id)initWithPhotoSource:(EGOPhotoSource*)aSource;
- (void)didSelectThumbAtIndex:(NSInteger)index;

@property(nonatomic,readonly) EGOPhotoSource *photoSource;

@end
