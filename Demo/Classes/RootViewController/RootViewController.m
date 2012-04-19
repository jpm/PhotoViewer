//
//  RootViewController.m
//  EGOPhotoViewer
//
//  Created by Devin Doty on 1/8/10.
//  Copyright enormego 2010. All rights reserved.
//

#import "RootViewController.h"
#import "EGOPhotoViewController.h"
#import "EGOThumbsViewController.h"
#import "EGOPhotoSource.h"
#import "EGOPhoto.h"

@implementation RootViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Root";
	[self.navigationController setToolbarHidden:YES animated:NO];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated]; 
	[self.navigationController setToolbarHidden:YES animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (UIInterfaceOrientationIsLandscape(interfaceOrientation) || interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if (indexPath.row == 0) {	
		cell.textLabel.text = @"Photos";
	} else if (indexPath.row == 1) {
		cell.textLabel.text = @"Single Photo";
	} else if (indexPath.row == 2) {
		cell.textLabel.text = @"Thumbs";
	} else {
		cell.textLabel.text = @"Thumbs (edit enabled)";
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	EGOPhoto *photo = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://a3.twimg.com/profile_images/66601193/cactus.jpg"] name:@" laksd;lkas;dlkaslkd ;a"];
	EGOPhoto *photo2 = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/twitter_production/profile_images/425948730/DF-Star-Logo.png"] name:@"lskdjf lksjdhfk jsdfh ksjdhf sjdhf ksjdhf ksdjfh ksdjh skdjfh skdfjh "];
	EGOPhoto *photo3 = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://fc09.deviantart.net/fs70/f/2010/024/6/2/Pug_by_SiteTheWhiteMoonWolf.jpg"]
																							 thumbURL:[NSURL URLWithString:@"http://t2.gstatic.com/images?q=tbn:KfymILFA-MbHWM:http://communities.canada.com/victoriatimescolonist/cfs-file.ashx/__key/CommunityServer.Components.UserFiles/00.00.02.01.21/sick-pug.jpg"]];
	EGOPhoto *photo4 = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/broken_image.jpg"] 
																							 thumbURL:[NSURL URLWithString:@"http://example.com/broken_thumb.jpg"]
																									 name:@"title title title"];	
	
	if (indexPath.row == 0) {
		EGOPhotoSource *source = [[EGOPhotoSource alloc] initWithEGOPhotos:[NSArray arrayWithObjects:photo, photo2, photo3, photo4, photo, photo2, photo3, photo4, nil]];
		
		EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
		[self.navigationController pushViewController:photoController animated:YES];
		[photoController release];
		[source release];
		
	} else if (indexPath.row == 1) {
		
		EGOPhotoSource *source = [[EGOPhotoSource alloc] initWithEGOPhotos:[NSArray arrayWithObjects:photo2, nil]];
		EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
		[self.navigationController pushViewController:photoController animated:YES];
		[photoController release];
		[source release];
		
	} else {
		
		EGOPhotoSource *source = [[EGOPhotoSource alloc] initWithEGOPhotos:[NSArray arrayWithObjects:photo, photo2, photo3, photo4, 
																																																 photo, photo2, photo3, photo4,
																																																 photo, photo2, photo3, photo4, 
																																																 photo, photo2, photo3, photo4, 
																																																 photo, photo2, photo3, photo4, 
																																																 photo, photo2, photo3, photo4, 
																																																 nil]];
		
		EGOThumbsViewController *thumbsController;
		if (indexPath.row == 2) {
			thumbsController = [[EGOThumbsViewController alloc] initWithPhotoSource:source];
		} else {
			thumbsController = [[EGOThumbsViewController alloc] initWithPhotoSource:source withEditingEnabled:YES];
		}
		[self.navigationController pushViewController:thumbsController animated:YES];
		[thumbsController release];
		[source release];		
		
	}
	
	[photo release];
	[photo2 release];
	[photo3 release];
	[photo4 release];	
	
}

- (void)dealloc {
	[super dealloc];
}


@end

