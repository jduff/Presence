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
@synthesize statusUpdates;

- (id) initWithUsername:(NSString *)value {
	if(self == [super init]) {
		self.username = value;
		[self loadData];
	}
	return self;
}

- (NSArray *) statusUpdates {
	NSLog(@"Accessing statusUpdates");
	if(statusUpdates == nil){
		NSLog(@"Loading statusUpdates");
		statusUpdates = [[TwitterHelper fetchTimelineForUsername:self.username] retain];
	}
	return statusUpdates;
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
	NSData *imageData = [[NSData alloc] 
						  initWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"profile_image_url"]]];
	
	self.profileImage = [[UIImage alloc] initWithData:imageData];
	self.displayName = [data objectForKey:@"screen_name"];
	[imageData release];
}

- (void) dealloc {
	[username release];
	[statusUpdates release];
	[displayName release];
	[profileImage release];
	[super dealloc];
}

@end
