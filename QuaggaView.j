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
