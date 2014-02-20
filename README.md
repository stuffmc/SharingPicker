NSSharingService activityType?
---


How to do this horrible `description indexOfString` nicer?

Can't find any property helping in `NSSharingService` :(

See mostly `AppDelegate.m`

**My category**

@implementation NSSharingService (ActivityType)

	@implementation NSSharingService (ActivityType)
	
	- (NSString*)activityType {
	    NSRange range = [self.description rangeOfString:@"\\[com.apple.share.System.*\\]" options:NSRegularExpressionSearch];
	    range.location++; // Start after [
	    range.length -= 2; // Remove both [ and ]
	    return [self.description substringWithRange:range];
	}
	@end
	
Allows you to do

	[[sharingService activityType] isEqualToString:NSSharingServiceNameAddToSafariReadingList];
	
    [@[NSSharingServiceNameAddToSafariReadingList, NSSharingServiceNameAddToIPhoto] containsObject:[sharingService activityType]];

Also check this out: http://stackoverflow.com/questions/21797141/nssharingservice-how-to-compare-with-the-constants/21904921

__PS__: And how to avoid that `should not be called on mouseUp` warning?