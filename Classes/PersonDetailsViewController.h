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
}

@property (nonatomic, retain) Person *person;

- (NSString *)statusAtIndex:(NSInteger)index;
@end
