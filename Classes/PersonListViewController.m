//
//  PersonListViewController.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PersonListViewController.h"
#import "PersonDetailsViewController.h"
#import "ImageLoadingOperation.h"
#import "TwitterHelper.h"

NSString *const TwitterUsername = @"username";
NSString *const TwitterPassword = @"password";

@implementation PersonListViewController

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
    if (self) {
		NSLog(@"loading");
		people = [[NSMutableArray alloc] init];
		imageCache = [[NSMutableDictionary alloc] init];

		UIBarButtonItem *composeButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
																   target:self 
																   action:@selector(composeButtonPressed:)]; 
		self.navigationItem.rightBarButtonItem = composeButtonItem;
		[composeButtonItem release];
	
		operationsQueue = [[NSOperationQueue alloc] init];
		[operationsQueue setMaxConcurrentOperationCount:1];
		
		[self beginLoadingTwitterUsers];
	}
	return self;
}

- (void) dealloc {
	[imageCache release];
	[operationsQueue release];
	[people release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"People";
	self.tableView.rowHeight = 56; // 75 pixel square image + 10 pixels of padding on either side.
}

- (void) composeButtonPressed:(id)sender{
	StatusComposeViewController *composeView = [[StatusComposeViewController alloc] 
												initWithNibName:@"StatusComposeView" 
												bundle:[NSBundle mainBundle]];
	composeView.delegate = self;
	
	[self presentModalViewController:composeView animated:YES];
	[composeView release];
}

- (void) statusComposeViewDidFinish:(StatusComposeViewController *) statusView withText:(NSString *)text {
	NSLog(@"Compose View Did Finish on delegate");
	[self showLoadingIndicators];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self 
																			selector:@selector(sendMessage:) 
																			  object:text];
	[operationsQueue addOperation:operation];
	[operation release];
	[self dismissModalViewControllerAnimated:YES];
}


- (void) sendMessage:(NSString *)message {
	[TwitterHelper updateStatus:message forUsername:TwitterUsername withPassword:TwitterPassword];
	
	[self performSelectorOnMainThread:@selector(didFinishSendingMessage) 
						   withObject:nil 
						waitUntilDone:NO];
}

- (void) didFinishSendingMessage {
	[self hideLoadingIndicators];
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
#pragma mark Loading Twitter Users

- (void) beginLoadingTwitterUsers {
	[self showLoadingIndicators];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self 
																			selector:@selector(loadTwitterUsers) 
																			  object:nil];
	[operationsQueue addOperation:operation];
	[operation release];
}

- (void) loadTwitterUsers {
	// Load the list of people into an array
	NSArray *data= [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] 
													  pathForResource:@"TwitterUsers" 
													  ofType:@"plist"]];
	// Create an ayyay of Person objects from the people
	NSMutableArray *users = [[NSMutableArray alloc] init];
	for(id user in data) {
		[users addObject:[[Person alloc] initWithUsername:user]];
	}
	
	[self performSelectorOnMainThread:@selector(didFinishLoadingTwitterUsers:) withObject:users waitUntilDone:NO];
}

- (void) didFinishLoadingTwitterUsers:(NSMutableArray *)users {
	people = users;
	
	[self hideLoadingIndicators];
	[self.tableView reloadData];
	[self.tableView flashScrollIndicators];
}

#pragma mark -
#pragma mark Loading Profile Images

- (UIImage *) getImageForURL:(NSURL *)url {
	id cachedObject = [imageCache objectForKey:url];
	
	if(cachedObject == nil) {
		// Set the loading placeholder in our cache
        [imageCache setObject:@"Loading" forKey:url];        
        
        // Create new image loading operation
        ImageLoadingOperation *operation = [[ImageLoadingOperation alloc] 
											initWithImageURL: url 
											target:self 
											selector:@selector(didFinishLoadingImageWithResult:)];
        [operationsQueue addOperation:operation];
        [operation release];
	} else if(![cachedObject isKindOfClass:[UIImage class]]) {
		// we're loading it already
		cachedObject = nil;
	}
	
	return cachedObject;
}

- (void) didFinishLoadingImageWithResult:(NSDictionary *)result {
	NSURL *url = [result objectForKey:@"url"];
    UIImage *image = [result objectForKey:@"image"];
    
    // Store the image in cache
    [imageCache setObject:image forKey:url];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark TableView Protocol Implementations 

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
	cell.imageView.image = [self getImageForURL: [[people objectAtIndex:indexPath.row] profileImageURL]];
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

@end
