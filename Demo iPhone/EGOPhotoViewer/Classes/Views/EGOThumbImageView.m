//
//  EGOThumbImageView.m
//  EGOPhotoViewer
//
//  Created by Henrik Nyh on 2010-06-25.
//  Copyright 2010 Henrik Nyh. All rights reserved.
//

#import "EGOThumbImageView.h"

// TODO: Replace these.
#define kPhotoErrorPlaceholder [UIImage imageNamed:@"error_placeholder.png"]
#define kPhotoLoadingPlaceholder [UIImage imageNamed:@"photo_placeholder.png"]

@implementation EGOThumbImageView

@synthesize controller, photo, imageView;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    newImageView.contentMode = UIViewContentModeScaleAspectFill;
    newImageView.clipsToBounds = YES;
    self.imageView = newImageView;
    [self addSubview:newImageView];
    [newImageView release];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:activityView];
    CGFloat activityLeft = (self.frame.size.width - activityView.frame.size.width) / 2;
    CGFloat activityTop = (self.frame.size.height - activityView.frame.size.height) / 2;
    activityView.frame = CGRectMake(activityLeft, activityTop, activityView.frame.size.width, activityView.frame.size.height);
    
    [self addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)setPhoto:(EGOPhoto*)aPhoto{	
	if (aPhoto == nil) return;
  
	[photo release], photo = nil;
	photo = [aPhoto retain];
  
	self.imageView.image = [[EGOImageLoader sharedImageLoader] imageForURL:photo.thumbURL shouldLoadWithObserver:self];
	
	if (self.imageView.image != nil) {  // Loaded from cache.
		[activityView stopAnimating];
	} else {
		[activityView startAnimating];
		self.imageView.image = kPhotoLoadingPlaceholder;
	}
}

#pragma mark -
#pragma mark Button

- (void)didTouch:(id)sender {
  if (self.controller) {
    [self.controller didSelectThumbAtIndex:([self tag]-kThumbTagOffset)];
  }  
}

#pragma mark -
#pragma mark EGOImageLoader Callbacks

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if ([notification userInfo] == nil) return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.photo.thumbURL]) return;
  
  self.imageView.image = [[notification userInfo] objectForKey:@"image"];  
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if ([notification userInfo] == nil) return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.photo.thumbURL]) return;
	
	self.imageView.image = kPhotoErrorPlaceholder;
	[activityView stopAnimating];
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.photo.thumbURL];
  
  self.controller = nil;
  self.imageView = nil;
  [activityView release], activityView = nil;
  [super dealloc];
}


@end
