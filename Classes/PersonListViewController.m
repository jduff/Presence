//
//  PersonListViewController.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PersonListViewController.h"
#import "PersonDetailsViewController.h"
#import "Person.h"


@implementation PersonListViewController

- (id)initWithStyle:(UITableViewStyle)style {
	[super initWithStyle:style];
	NSLog(@"loading");
	
	// Load the list of people into an array
	NSArray *data= [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] 
													  pathForResource:@"TwitterUsers" 
													  ofType:@"plist"]];
	// Create an ayyay of Person objects from the people
	people = [[NSMutableArray alloc] init];
	for(id user in data) {
		[people addObject:[[Person alloc] initWithUsername:user]];
	}
	[people retain];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"People";
	self.tableView.rowHeight = 56; // 75 pixel square image + 10 pixels of padding on either side.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"number of people %d",[people count]);
	return [people count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListItem"]; 
	if (cell == nil) { 
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserListItem"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} 
	cell.textLabel.text = [[people objectAtIndex:indexPath.row] displayName];
	cell.imageView.image = [[people objectAtIndex:indexPath.row] profileImage];
	NSLog(@"display name %@", [[people objectAtIndex:indexPath.row] displayName]);
	return cell;		
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	PersonDetailsViewController *detailsView = [[PersonDetailsViewController alloc] 
												initWithStyle:UITableViewStyleGrouped];
	
	detailsView.person = [people objectAtIndex:indexPath.row];
	
	[[self navigationController] pushViewController:detailsView
										   animated:YES];
	[detailsView release];
}

- (void) dealloc {
	[people release];
	[super dealloc];
}

@end
