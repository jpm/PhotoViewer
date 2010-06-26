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
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Root";
	[self.navigationController setToolbarHidden:YES animated:NO];
  
}



- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated]; 
	[self.navigationController setToolbarHidden:YES animated:YES];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (UIInterfaceOrientationIsLandscape(interfaceOrientation) || interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}


// Customize the appearance of table view cells.
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
  } else {
    cell.textLabel.text = @"Thumbs";
  }
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
  
	// Configure the cell.
  
  return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  // TODO: Use separate thumbs...
  NSURL *sharedThumbURL = [NSURL URLWithString:@"http://image.made-in-china.com/3f2j00tvoQODhqAlkm/Thumb-s-UP-Precision-Mini-in-a-Try-Me-Product.jpg"];
  EGOPhoto *photo = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://a3.twimg.com/profile_images/66601193/cactus.jpg"] thumbURL:sharedThumbURL name:@" laksd;lkas;dlkaslkd ;a"];
  EGOPhoto *photo2 = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/twitter_production/profile_images/425948730/DF-Star-Logo.png"] thumbURL:sharedThumbURL name:@"lskdjf lksjdhfk jsdfh ksjdhf sjdhf ksjdhf ksdjfh ksdjh skdjfh skdfjh "];
  EGOPhoto *photo3 = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://qkpic.com/21b2c"] thumbURL:sharedThumbURL];
  EGOPhoto *photo4 = [[EGOPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://qkpic.com/13493"] thumbURL:sharedThumbURL name:@"title title title"];  
  
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
		
		EGOThumbsViewController *thumbsController = [[EGOThumbsViewController alloc] initWithPhotoSource:source];
		[self.navigationController pushViewController:thumbsController animated:YES];
		[thumbsController release];
		[source release];    
    
  }
  
  [photo release];
  [photo2 release];
  [photo3 release];
  [photo4 release];  
  
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
  [super dealloc];
}


@end

