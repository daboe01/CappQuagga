/*
 * AppController.j
 *
 *  Manual test application for the timelineview 
 *  Copyright (C) 2016 Daniel Boehringer
 */
 
@import "QuaggaWindow.j"

@implementation AppController : CPObject


- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{

    var theWindow = [QuaggaWindow sharedWindow];
    [theWindow setDelegate:self];
    [theWindow orderFront:self];
}
- (void)quaggaWindow:(id)theWindow detectedString:(CPString)data
{
    alert(data)
}

@end
