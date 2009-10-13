//
//  DownloadImageOperation.m
//  Presence
//
//  Created by John Duff on 09-10-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageLoadingOperation.h"


@implementation ImageLoadingOperation

- (id) initWithImageURL:(NSURL *)url target:(id)theTarget selector:(SEL)theSelector {
	if(self = [super init]) {
		imageURL = [url retain];
		target = theTarget;
		selector = theSelector;
	}
	return self;
}

- (void) dealloc {
	[imageURL release];
	[super dealloc];
}

- (void) main {
	NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
	
	UIImage *image = [[UIImage alloc] initWithData:imageData];
	if(image == nil){
		image = [[UIImage alloc] init];
	}
	NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", imageURL, @"url", nil];
	
	[target performSelectorOnMainThread:selector withObject:result waitUntilDone:NO];
	
	[imageData release];
	[image release];
}

@end
