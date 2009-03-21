//
//  DropView.h
//  DropAndMove
//
//  Created by Patrick on 21.03.09.
//  Copyright 2009 Patrick Mosby. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DropView : NSView {
    NSImage *_myImage;
}

- (void)setImage:(NSImage *)newImage;
- (NSImage *)image;

@end
