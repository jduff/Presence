//
//  PersonDetailsViewController.h
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"


@interface PersonDetailsViewController : UITableViewController {
	Person *person;
	NSArray *statusUpdates;
	NSOperationQueue *operationsQueue;
	UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) Person *person;
@property (nonatomic, retain) NSArray *statusUpdates;

- (NSString *)statusAtIndex:(NSInteger)index;
- (void) finishedLoadingStatusUpdates:(NSArray *)updates;
- (void) loadStatusUpdates;

- (void)showLoadingIndicators;
- (void)hideLoadingIndicators;
@end
