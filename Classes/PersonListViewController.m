//
//  PersonListViewController.m
//  Presence
//
//  Created by John Duff on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PersonListViewController.h"
#import "PersonDetailsViewController.h"


@implementation PersonListViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	if(self == [super initWithNibName:nibName bundle:bundle]) {
		self.title = @"People";
		
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
		[rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
		self.navigationItem.rightBarButtonItem = rightButtonItem;
		[rightButtonItem release];
	}
	return self;
}

- (IBAction)rightButtonAction:(id)sender{
	UIAlertView *infoAlert = [[UIAlertView alloc]
							   initWithTitle: @"Info"
							   message: @"I am Presence"
							   delegate:nil
							   cancelButtonTitle:@"OK"
							   otherButtonTitles:nil];
    [infoAlert show];
    [infoAlert release];
	
}

- (IBAction)viewPerson:(id)sender {
	PersonDetailsViewController *detailsView = [[PersonDetailsViewController alloc] initWithNibName:@"PersonDetailsView" 
																							 bundle:[NSBundle mainBundle]];
	if(sender == joshButton) {
		detailsView.status = @"I am the Awesome Josh!";
		detailsView.name = @"Josh";
		detailsView.image = joshImage.image;
	}
	else {
		detailsView.status = @"Geoff is doing iPhone stuff!";
		detailsView.name = @"Geoff";
		detailsView.image = geoffImage.image;
	}
    [self.navigationController pushViewController: detailsView animated:YES];
	[detailsView release];
}

@end
