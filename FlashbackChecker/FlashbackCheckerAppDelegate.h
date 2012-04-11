/* FlashbackCheckerAppDelegate */

#import <Cocoa/Cocoa.h>

@interface FlashbackCheckerAppDelegate : NSObject
{
    IBOutlet id textView;
    IBOutlet id window;
}
- (IBAction)checkForInfection:(id)sender;

- (void)log:(NSString*)aString;

- (id)valueForKey:(NSString*)aKey atPath:(NSString*)aPath;

@end
