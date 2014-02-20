//
//  AppDelegate.m
//  SharingPicker
//
//  Created by Manuel "StuFF mc" Carrasco Molina on 18/02/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (IBAction)share:(NSButton*)sender {
    NSSharingServicePicker *sharingServicePicker = [[NSSharingServicePicker alloc] initWithItems:@[@"Stay hungry, stay foolish!", [NSURL URLWithString:@"http://apple.com"]]];
    sharingServicePicker.delegate = self;
    CGRect frame = sender.frame;
    frame.origin.y -= frame.size.height + 14; // Showing the Picker under the button, much like in Safari.
    [sharingServicePicker showRelativeToRect:frame ofView:sender.superview preferredEdge:NSMinXEdge];
}

#pragma mark - NSSharingServicePickerDelegate

- (id <NSSharingServiceDelegate>)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker delegateForSharingService:(NSSharingService *)sharingService
{
    return self;
}

#pragma mark - NSSharingServiceDelegate


- (void)sharingService:(NSSharingService *)sharingService didFailToShareItems:(NSArray *)items error:(NSError *)error
{
    [NSAlert alertWithError:error];
}

- (void)sharingService:(NSSharingService *)sharingService didShareItems:(NSArray *)items
{
    BOOL isReadingList = [sharingService.description rangeOfString:NSSharingServiceNameAddToSafariReadingList].location != NSNotFound;
    NSLog(@"isReadingList range: %d", isReadingList);
    NSLog(@"act: %@", [sharingService activityType]);
    isReadingList = [[sharingService activityType] isEqualToString:NSSharingServiceNameAddToSafariReadingList];
    NSLog(@"isReadingList iequa: %d", isReadingList);
    isReadingList = [@[NSSharingServiceNameAddToSafariReadingList, NSSharingServiceNameAddToIPhoto] containsObject:[sharingService activityType]];
    NSLog(@"isReadingList conta: %d", isReadingList);
}

@end

@implementation NSSharingService (ActivityType)

- (NSString*)activityType
{
    NSRange range = [self.description rangeOfString:@"\\[com.apple.share.*\\]" options:NSRegularExpressionSearch];
    range.location++; // Start after [
    range.length -= 2; // Remove both [ and ]
    return [self.description substringWithRange:range];
}

@end
