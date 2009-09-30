//
//  PersonDetailsViewController.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PersonDetailsViewController.h"

@implementation PersonDetailsViewController

@synthesize person;

- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"showing details view");
	self.title = person.displayName;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UILabel *label = [[UILabel alloc] init];
	label.text = @"    Statuses";
	label.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	label.backgroundColor = [UIColor clearColor];
	return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return [@"Statuses" sizeWithFont:[UIFont systemFontOfSize:[UIFont labelFontSize]]].height + 4.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"number of updates %d",[person.statusUpdates count]);
	return [person.statusUpdates count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserStatusItem"]; 
	if (cell == nil) { 
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserStatusItem"];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	} 
	NSLog(@"status %@", [self statusAtIndex:indexPath.row]);
	cell.textLabel.text = [self statusAtIndex:indexPath.row];
	return cell;		
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [[self statusAtIndex:indexPath.row] 
			sizeWithFont:[UIFont systemFontOfSize:[UIFont labelFontSize]] 
			constrainedToSize:CGSizeMake(self.view.bounds.size.width - 20.0, 400.0)].height + 4.0;
}

- (NSString *)statusAtIndex:(NSInteger)index {
	return [[person.statusUpdates objectAtIndex:index] objectForKey:@"text"];
}

- (void) dealloc {
	NSLog(@"details view dealloc");
	[person release];
	[super dealloc];
}


@end
