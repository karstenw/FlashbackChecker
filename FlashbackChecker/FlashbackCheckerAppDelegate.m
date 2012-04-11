//
//  AppDelegate.m
//  FlashBackChecker
//
//  Created by Juan Leon on 4/5/12.
//  Copyright (c) 2012 NotOptimal.net. All rights reserved.
//


#import "FlashbackCheckerAppDelegate.h"

@implementation FlashbackCheckerAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
#pragma unused(theApplication)
    
    return YES;
}

- (IBAction)checkForInfection:(id)aSender
{
# pragma unused(aSender)
    
    [textView setString:@""];
        
    
    NSString* theSafari = @"/Applications/Safari.app/Contents/Info.plist";
    NSString* theFirefox = @"/Applications/Firefox.app/Contents/Info.plist";
    NSString* theEnvironment = @"~/.MacOSX/environment.plist";
    NSString *theFile;
    NSArray* theFiles = [NSArray arrayWithObjects:theSafari, theFirefox, theEnvironment, nil];
    BOOL theInfected = NO;

    NSEnumerator *e = [theFiles objectEnumerator];

    while (false != (theFile = [e nextObject])) {

        NSString* theKey = @"LSEnvironment";
        if( [theFile isEqualToString: theEnvironment] )
        {
            theKey = @"DYLD_INSERT_LIBRARIES";
        }
        
        id theObject = [self valueForKey:theKey atPath:theFile];
        if( theObject )
        {
            [self log: @""];
            [self log:[NSString stringWithFormat:@"Potential Issue found at: %@", theFile]];
            [self log:[theObject description]];
            [self log: @"" ];
            theInfected = YES;
        }
        else 
        {
            NSString* thePath = [theFile stringByExpandingTildeInPath];
            if( [[NSFileManager defaultManager] fileExistsAtPath:thePath] )
            {
                [self log:[NSString stringWithFormat:@"Clear: %@", thePath]];
            }
            else
            {
                [self log:[NSString stringWithFormat:@"Clear (no file found): %@", thePath]];
            }
        }
    }
    
    if( !theInfected )
    {
        [self log:@"No Signs of infection were found."];
    }
    
    NSString* theVisit = @"\n\nVisit the F-Secure site for more information:\nhttp://www.f-secure.com/v-descs/trojan-downloader_osx_flashback_i.shtml";
    [self log:theVisit];
}

- (id)valueForKey:(NSString*)aKey atPath:(NSString*)aPath
{
    id theReturn = nil;
    
    NSString* thePath = [aPath stringByExpandingTildeInPath];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:thePath] )
    {
        NSDictionary* theDict = [NSDictionary dictionaryWithContentsOfFile:thePath];
        theReturn = [theDict objectForKey:aKey];
    }
    return theReturn;
}

- (void)log:(NSString*)aString
{
    NSString* theString = [textView string];
    [textView setString:[NSString stringWithFormat:@"%@%@\n", theString, aString]];
}

@end
