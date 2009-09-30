//
//  Person.h
//  Presence
//
//  Created by John Duff on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
	NSString	*username;
	NSString	*displayName;
	UIImage		*profileImage;
	NSArray		*statusUpdates;
	
}

@property(retain) NSString *username;
@property(retain) NSString *displayName;
@property(retain) UIImage *profileImage;
@property(readonly) NSArray *statusUpdates;

- (id) initWithUsername:(NSString *)value;

- (void) loadData;
@end
