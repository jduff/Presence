//
//  PresenceAppDelegate.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "PresenceAppDelegate.h"

@implementation PresenceAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[navigationController pushViewController: [[PersonListViewController alloc] initWithNibName:@"PersonListView" bundle:[NSBundle mainBundle]] animated: YES];

	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
