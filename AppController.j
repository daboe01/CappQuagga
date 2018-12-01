/*
 * AppController.j
 *
 *  Manual test application for the timelineview 
 *  Copyright (C) 2016 Daniel Boehringer
 */
 
@import "QuaggaView.j"

@implementation AppController : CPObject
{
    QuaggaView  _quaggaView;
}


- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{

    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
    
    [contentView setBackgroundColor:[CPColor colorWithWhite:0.95 alpha:1.0]];

    _quaggaView = [[QuaggaView alloc] initWithFrame:CGRectMake(0, 0,500,500)];

    [_quaggaView setDelegate:self];

    var scrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(20, 20,520,510)];
    [scrollView setDocumentView:_quaggaView];

    [[theWindow contentView] addSubview:scrollView];

    [theWindow orderFront:self];
}
- (void)quagga:(id)theQuagga detectedString:(CPString)data
{
    alert(data)
}

@end
