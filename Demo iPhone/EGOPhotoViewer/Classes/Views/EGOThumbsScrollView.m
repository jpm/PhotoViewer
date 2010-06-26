//
//  EGOThumbsScrollView.m
//  EGOPhotoViewer
//
//  Created by Henrik Nyh on 2010-06-25.
//  Copyright 2010 Henrik Nyh. All rights reserved.
//
//  Based heavily on KTPhotoBrowser by Kirby Turner.

#import "EGOThumbsScrollView.h"
#import "EGOPhoto.h"
#import "EGOThumbImageView.h"

@implementation EGOThumbsScrollView

#define kThumbSize 75
#define kThumbMinimumSpace 3

@synthesize controller, photoSource;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
	}
	return self;
}

- (void)layoutSubviews {
	if (!self.photoSource) return;
	
	// We only want this called once per orientation change.
	if (self.controller.interfaceOrientation == laidOutForOrientation) return;
	laidOutForOrientation = self.controller.interfaceOrientation;
	
	int viewWidth = self.bounds.size.width;
	
	int itemsPerRow = floor((viewWidth - kThumbMinimumSpace) / (kThumbSize + kThumbMinimumSpace));	
	if (itemsPerRow < 1) itemsPerRow = 1;	// Ensure at least one per row.
	
	int spaceWidth = round((viewWidth - kThumbSize * itemsPerRow) / (itemsPerRow + 1));
	int spaceHeight = spaceWidth;
	
	int x = spaceWidth;
	int y = spaceHeight;
	
	// Calculate content size.
	
	int photoCount = [self.photoSource count];
	int rowCount = ceil(photoCount / (float)itemsPerRow);
	int rowHeight = kThumbSize + spaceHeight;
	CGSize contentSize = CGSizeMake(viewWidth, (rowHeight * rowCount + spaceHeight));
	
	self.contentSize = contentSize;
	
	// Add/move thumbs.
	for (int i = 0; i < photoCount; i++) {
		
		int tag = kThumbTagOffset + i;
		
		EGOThumbImageView *thumbView = (EGOThumbImageView *)[self viewWithTag:tag];
		CGRect thumbFrame = CGRectMake(x, y, kThumbSize, kThumbSize);
		if (!thumbView) {		
			EGOPhoto *photo = [self.photoSource photoAtIndex:i];
			thumbView = [[EGOThumbImageView alloc] initWithFrame:thumbFrame];
			thumbView.photo = photo;
			thumbView.controller = self.controller;
			thumbView.tag = tag;	// Used when thumb is tapped.
			[self addSubview:thumbView];
			[thumbView release];
		}
		thumbView.frame = thumbFrame;
		
		// Set the position of the next thumb.
		if ((i+1) % itemsPerRow == 0) {
			// Start new row.
			x = spaceWidth;
			y += kThumbSize + spaceHeight;
		} else {
			x += kThumbSize + spaceWidth;
		}
	}
	
}

- (void)dealloc {
	self.photoSource = nil;
	[super dealloc];
}


@end
