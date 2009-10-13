//
//  DownloadImageOperation.h
//  Presence
//
//  Created by John Duff on 09-10-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageLoadingOperation : NSOperation {
	NSURL *imageURL;
	id target;
	SEL selector;
}

- (id) initWithImageURL:(NSURL *)url target:(id)theTarget selector:(SEL)theSelector;

@end
