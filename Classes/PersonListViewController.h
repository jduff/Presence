//
//  PersonListViewController.h
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "StatusComposeViewController.h"


@interface PersonListViewController : UITableViewController <StatusComposeViewProtocol> {
	NSMutableArray *people;
	NSOperationQueue *operationsQueue;
	UIActivityIndicatorView *spinner;
	NSMutableDictionary *imageCache;
}

- (void)showLoadingIndicators;
- (void)hideLoadingIndicators;

- (void) beginLoadingTwitterUsers;
- (void) loadTwitterUsers;
- (void) didFinishLoadingTwitterUsers:(NSArray *)users;
- (UIImage *) getImageForURL:(NSURL *)url;
- (void) didFinishLoadingImageWithResult:(NSDictionary *)result;

- (void) composeButtonPressed:(id)sender;

- (void) sendMessage:(NSString *)message;
- (void) didFinishSendingMessage;

@end
