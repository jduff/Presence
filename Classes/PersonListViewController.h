//
//  PersonListViewController.h
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonListViewController : UIViewController {
	IBOutlet UIButton *joshButton;
	IBOutlet UIButton *geoffButton;
	IBOutlet UIImageView *joshImage;
	IBOutlet UIImageView *geoffImage;
}

- (IBAction)viewPerson:(id)sender;
- (IBAction)rightButtonAction:(id)sender;

@end
