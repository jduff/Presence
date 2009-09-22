//
//  PersonDetailsViewController.h
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonDetailsViewController : UIViewController {
    IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *statusLabel;
	IBOutlet UIImageView *imageView;
	
	NSString *name;
	NSString *status;
	UIImage *image;
}

@property (assign) NSString *name;
@property (assign) NSString *status;
@property (assign) UIImage *image;


@end
