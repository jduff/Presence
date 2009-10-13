//
//  StatusComposeViewController.h
//  Presence
//
//  Created by John Duff on 09-10-12.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StatusComposeViewProtocol;

@interface StatusComposeViewController : UIViewController {
	IBOutlet UITextField *statusInput;
	IBOutlet UIBarButtonItem *sendButton;
	IBOutlet UIBarButtonItem *cancelButton;
	IBOutlet UILabel *charactersRemaining;
	id<StatusComposeViewProtocol> delegate;
}

@property (nonatomic, retain) id delegate;
- (IBAction) cancelButtonPressed:(id)sender;
- (IBAction) sendButtonPressed:(id)sender;

@end

@protocol StatusComposeViewProtocol <NSObject>
@optional

-(void) statusComposeViewDidFinish:(StatusComposeViewController *)statusView withText:(NSString *)text;

@end