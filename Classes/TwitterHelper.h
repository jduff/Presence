//
//  TwitterHelper.h
//  Presence
//

#import <UIKit/UIKit.h>

// Read about Twitter's API at http://apiwiki.twitter.com/
// Read about json-framework at http://code.google.com/p/json-framework

// Define USE_CACHED_DATA as 1 to use the CS193P test server when possible and avoid rate-limiting while developing.
// Define it as 0 (or comment it out) to use real live data from Twitter at all times.
// Read more at http://apiwiki.twitter.com/Rate-limiting
#define USE_CACHED_DATA 1

@interface TwitterHelper : NSObject {
	
}

// Returns a dictionary with info about the given username.
// This method is synchronous (it will block the calling thread).
+ (NSDictionary *)fetchInfoForUsername:(NSString *)username;

// Returns an array of status updates for the given username.
// This method is synchronous (it will block the calling thread).
+ (NSArray *)fetchTimelineForUsername:(NSString *)username;

// Returns YES if the status update succeeded, otherwise NO.
+ (BOOL)updateStatus:(NSString *)status forUsername:(NSString *)username withPassword:(NSString *)password;

@end
