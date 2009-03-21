//
//  DropView.m
//  DropAndMove
//
//  Created by Patrick on 21.03.09.
//  Copyright 2009 Patrick Mosby. All rights reserved.
//

#import "DropView.h"


@implementation DropView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    // Drawing code here.
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) {
        return NSDragOperationGeneric;
    } else {
        return NSDragOperationNone;
    }
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) {
        return NSDragOperationGeneric;
    } else {
        return NSDragOperationNone;
    }
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *paste = [sender draggingPasteboard];
    NSArray *types = [NSArray arrayWithObjects:NSTIFFPboardType, NSFilenamesPboardType, nil];
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
    
    if (nil == carriedData) {
        NSRunAlertPanel(@"Paste Error",
                        @"Sorry, but the paste operation failed",
                        nil,
                        nil,
                        nil);
        return NO;
    } else {
        if ([desiredType isEqualToString:NSTIFFPboardType]) {
            NSImage *newImage = [[NSImage alloc] initWithData:carriedData];
            [self setImage:newImage];
            [newImage release];
        } else if ([desiredType isEqualToString:NSFilenamesPboardType]) {
            NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
            NSString *path = [fileArray objectAtIndex:0];
            NSImage *newImage = [[NSImage alloc] initWithContentsOfFile:path];
            
            if (nil == newImage) {
                NSRunAlertPanel(@"File Reading Error",
                                [NSString stringWithFormat:@"Sorry, but I failed to open the file at \"@\"", path],
                                nil,
                                nil,
                                nil);
                return NO;
            } else {
                [self setImage:newImage];
            }
            
            [newImage release];
        } else {
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    
    [self setNeedsDisplay:YES];
    return YES;
    
    
    
}
@end
