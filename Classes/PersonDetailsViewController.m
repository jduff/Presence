//
//  PersonDetailsViewController.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PersonDetailsViewController.h"

@implementation PersonDetailsViewController

@synthesize name;
@synthesize status;
@synthesize image;

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	if(self == [super initWithNibName:nibName bundle:bundle]) {
		self.title = @"Details";
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	statusLabel.text	= status;
	nameLabel.text		= name;
	imageView.image		= image;
	
	[super viewWillAppear:animated];
}


@end
