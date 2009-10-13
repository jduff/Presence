//
//  StatusComposeViewController.m
//  Presence
//
//  Created by John Duff on 09-10-12.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StatusComposeViewController.h"


@implementation StatusComposeViewController
@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *testString = [textField.text stringByReplacingCharactersInRange:range withString:string];
	
	charactersRemaining.text = [NSString stringWithFormat:@"%d", (140-[testString length])];
	
    if( testString.length>0 && ([testString length]) <= 140 ) {
        sendButton.enabled = YES;
	} else {
        sendButton.enabled = NO;
	}
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if ([textField.text length]<=140) {
		[textField resignFirstResponder];
		
		if([self.delegate respondsToSelector:@selector(statusComposeViewDidFinish:withText:)]) {
			NSLog(@"Compose View Did Finish");
			[self.delegate statusComposeViewDidFinish:self withText:textField.text];
		}
		return YES;		
	} else {
		return NO;
	}

}

-(IBAction) cancelButtonPressed:(id)sender {
	if([self.delegate respondsToSelector:@selector(statusComposeViewDidFinish:withText:)]) {
		NSLog(@"Compose View Did Finish");
		[self.delegate statusComposeViewDidFinish:self withText:nil];
	}
}

- (IBAction) sendButtonPressed:(id)sender {
	[self textFieldShouldReturn:statusInput];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
