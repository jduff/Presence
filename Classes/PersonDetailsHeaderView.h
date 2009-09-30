//
//  PersonDetailsHeaderView.h
//  Presence
//
//  Created by John Duff on 29/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonDetailsHeaderView : UIViewController {
	IBOutlet UIImageView *imageView;
	UIImage				 *image;
}

@property(nonatomic, retain) UIImage *image;
- (id) initWithImage:(UIImage *)theImage;

@end
