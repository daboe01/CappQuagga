/*
 * QuaggaView.j
 *
 * Created by daboe01 on November 25, 2018.
 * Copyright 2018, Daniel Boehringer All rights reserved.
 */

@import <Foundation/CPObject.j>

@implementation QuaggaView : CPView
{
    id _delegate @accessors(property=delegate);
}

- (id)initWithFrame:(CGRect)aFrame
{
    if (self = [super initWithFrame:aFrame])
    {
        Quagga.init({
            inputStream : {
                name:"Live",
                type:"LiveStream",
                target:_DOMElement
            },
            decoder : {
                readers : ["code_128_reader"]
            }
        }, function(err) {
            if (err) {
                console.log(err);
                return
            }

            Quagga.onDetected(function(result){
                [_delegate quagga:self detectedString:result.codeResult.code];
            });
            Quagga.start();
       });

    }

    return self;
}

- (void)start:(id)sender
{
    Quagga.start();
}
- (void)stop:(id)sender
{
    Quagga.stop();
}

@end

var _sharedQuaggaWindow;

@implementation QuaggaWindow : CPWindow
{
    QuaggaView _quaggaView;
}

+ (QuaggaView)sharedWindow
{
    if (!_sharedQuaggaWindow)
    {

        _sharedQuaggaWindow = [[QuaggaWindow alloc] initWithContentRect:CGRectMake(0, 0, 500, 500) styleMask:CPTitledWindowMask|CPClosableWindowMask];
        [_sharedQuaggaWindow setTitle:@"Show me your barcodes!"];
        [_sharedQuaggaWindow center];
        var contentView = [_sharedQuaggaWindow contentView];

        [contentView setBackgroundColor:[CPColor colorWithWhite:0.95 alpha:1.0]];

        _sharedQuaggaWindow._quaggaView = [[QuaggaView alloc] initWithFrame:CGRectMake(0, 0,498, 480)];
        [_sharedQuaggaWindow._quaggaView setDelegate:_sharedQuaggaWindow];

        [contentView addSubview:_sharedQuaggaWindow._quaggaView];
    }

    return _sharedQuaggaWindow;
}

- (void)quagga:(id)theQuagga detectedString:(CPString)data
{
    [_delegate quaggaWindow:self detectedString:data];
}

- (void)start:(id)sender
{
    [self orderFront:sender];
    [_quaggaView start:self];
}

- (void)close
{
    [_quaggaView stop:self];
    [super close];
}

@end
