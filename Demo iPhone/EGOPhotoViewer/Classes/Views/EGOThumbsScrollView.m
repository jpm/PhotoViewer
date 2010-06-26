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

@synthesize controller, photoSource=_photoSource;


- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
  }
  return self;
}

- (void)removeAllSubviews {
  int count = [[self subviews] count];
  for (int i = count; i > 0; i--) {
    UIView *subview = [[self subviews] objectAtIndex:i - 1];
    [subview removeFromSuperview];
  }
}

- (void)layoutSubviews {
  if (!self.photoSource) return;
  
  if (self.controller.interfaceOrientation == laidOutForOrientation) return;
  laidOutForOrientation = self.controller.interfaceOrientation;
  NSLog(@"layout subviews of thumbs!");
  
  int viewWidth = self.bounds.size.width;
  
  int thumbnailWidth = 75;
  int thumbnailHeight = 75;
  
  int itemsPerRow = floor(viewWidth / thumbnailWidth);
  
  // Ensure a minimum of space between images.
  int minimumSpace = 5;
  if (viewWidth - itemsPerRow * thumbnailWidth < minimumSpace) {
    itemsPerRow--;
  }
  
  if (itemsPerRow < 1) itemsPerRow = 1;  // Ensure at least one per row.
  
  int spaceWidth = round((viewWidth - thumbnailWidth * itemsPerRow) / (itemsPerRow + 1));
  int spaceHeight = spaceWidth;
  
  int x = spaceWidth;
  int y = spaceHeight;
  
  // Calculate content size.
  
  int photoCount = [self.photoSource count];
  int rowCount = ceil(photoCount / (float)itemsPerRow);
  int rowHeight = thumbnailHeight + spaceHeight;
  CGSize contentSize = CGSizeMake(viewWidth, (rowHeight * rowCount + spaceHeight));
  
  self.contentSize = contentSize;
  
//  [self removeAllSubviews];
  
  // Add new subviews.
  for (int i = 0; i < photoCount; i++) {
    
    int tag = kThumbTagOffset + i;
    
    EGOThumbImageView *thumbView = (EGOThumbImageView *)[self viewWithTag:tag];
    if (!thumbView) {    
      EGOPhoto *photo = [self.photoSource photoAtIndex:i];
      thumbView = [[EGOThumbImageView alloc] initWithFrame:CGRectMake(x, y, thumbnailWidth, thumbnailHeight)];
      thumbView.photo = photo;
      thumbView.controller = self.controller;
      thumbView.tag = tag;  // Used when thumb is tapped.
      [self addSubview:thumbView];
      [thumbView release];
    }
    thumbView.frame = CGRectMake(x, y, thumbnailWidth, thumbnailHeight);
    
    // Adjust the position.
    if ((i+1) % itemsPerRow == 0) {
      // Start new row.
      x = spaceWidth;
      y += thumbnailHeight + spaceHeight;
    } else {
      x += thumbnailWidth + spaceWidth;
    }
  }
  
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)dealloc {
  self.photoSource = nil;
  [super dealloc];
}


@end
