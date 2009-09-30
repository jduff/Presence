//
//  PresenceAppDelegate.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "PresenceAppDelegate.h"
#import "Person.h"

@implementation PresenceAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    	
	[navigationController pushViewController: [[PersonListViewController alloc] 
												initWithStyle:UITableViewStylePlain] 
									animated: YES];

	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
