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
@synthesize statusUpdates;

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
    if (self) {
		operationsQueue = [[NSOperationQueue alloc] init];
		[operationsQueue setMaxConcurrentOperationCount:1];
		
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"showing details view");
	self.title = person.displayName;
	
	[self showLoadingIndicators];
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self 
																			selector:@selector(loadStatusUpdates) 
																			  object:nil];
	[operationsQueue addOperation:operation];
	[operation release];
}

- (void) loadStatusUpdates {
	[self performSelectorOnMainThread:@selector(finishedLoadingStatusUpdates:) 
						   withObject:person.statusUpdates 
						waitUntilDone:NO]; 
}

- (void) finishedLoadingStatusUpdates:(NSArray *)updates {
	self.statusUpdates = [updates retain];
	[self hideLoadingIndicators];
	[self.tableView reloadData];
	[self.tableView flashScrollIndicators];
}

#pragma mark -
#pragma mark Loading Indicators

- (void)showLoadingIndicators {
    if (!spinner) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        
        static CGFloat bufferWidth = 8.0;
        
        CGRect spinnerFrame = spinner.frame;
        spinnerFrame.origin.x = (self.tableView.bounds.size.width - spinnerFrame.size.width - bufferWidth) / 2.0;
        spinnerFrame.origin.y = (self.tableView.bounds.size.height - spinnerFrame.size.height) / 2.0;
        spinner.frame = spinnerFrame;
        [self.tableView addSubview:spinner];
    }
}

- (void)hideLoadingIndicators {
    if (spinner) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [spinner release];
        spinner = nil;
    }
}

#pragma mark -
#pragma mark Table View Delegate Methods

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
	NSLog(@"number of updates %d",[self.statusUpdates count]);
	return [self.statusUpdates count];
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
	return [[self.statusUpdates objectAtIndex:index] objectForKey:@"text"];
}

- (void) dealloc {
	NSLog(@"details view dealloc");
	[person release];
	[statusUpdates release];
	[super dealloc];
}


@end
