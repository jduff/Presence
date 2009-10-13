//
//  Person.m
//  Presence
//
//  Created by John Duff on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Person.h"
#import "TwitterHelper.h"

@implementation Person

@synthesize username;
@synthesize displayName;
@synthesize profileImage;
@synthesize profileImageURL;
@synthesize statusUpdates;

- (id) initWithUsername:(NSString *)value {
	if(self = [super init]) {
		self.username = value;
		[self loadData];
	}
	return self;
}

- (NSArray *) statusUpdates {
	NSLog(@"Accessing statusUpdates");
	return [[TwitterHelper fetchTimelineForUsername:self.username] autorelease];
}

- (NSString *) displayName {
	NSLog(@"Accessing display name");
	if(displayName == nil) {
		NSLog(@"display name is nil");
		return username;
	}
	else {
		NSLog(@"display name: %@", displayName);
		return displayName;
	}
}

- (void) loadData {
	NSLog(@"Loading data from Twitter");
	// load the data from twitter
	NSDictionary *data = [TwitterHelper fetchInfoForUsername:self.username];
	self.profileImageURL = [NSURL URLWithString:[data objectForKey:@"profile_image_url"]];
	self.displayName = [data objectForKey:@"screen_name"];
}

- (void) dealloc {
	[username release];
	[statusUpdates release];
	[displayName release];
	[profileImage release];
	[profileImageURL release];
	[super dealloc];
}

@end
