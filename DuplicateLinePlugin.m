//
//  DuplicateLinePlugin.m
//  Duplicate Line
//
//  Created by PJ Dietz on 12/2/11.
//  Copyright (c) 2011 American Reading Company. All rights reserved.
//

#import "DuplicateLinePlugIn.h"
#import "CodaPlugInsController.h"

@implementation DuplicateLinePlugIn

- (id)initWithPlugInController:(CodaPlugInsController*)inController bundle:(NSBundle*)aBundle
{
	if ((self = [super init]) != nil) {
        
		controller = inController;
	
        [controller
         registerActionWithTitle:NSLocalizedString(@"Duplicate Line", @"Duplicate Line")
         underSubmenuWithTitle:nil
         target:self
         selector:@selector(duplicateLine:)
         representedObject:nil
         keyEquivalent:@"@y"
         pluginName:@"Duplicate Line"];
	
    }
    
	return self;
}


- (NSString*)name
{
	return @"Duplicate Line";
}


- (void)duplicateLine:(id)sender
{
    
	CodaTextView *tv = [controller focusedTextView:self];
	
    if (tv) {

        // Read the range of the current line.
        NSRange currentLineRange = [tv rangeOfCurrentLine];
        
        // The insert range will be zero length and located after
        // the currentLineRange's end.
        NSRange insertRange = {
            currentLineRange.location + currentLineRange.length + 1,
            0
        };
        
        // Insert the current line and a line ending.
        NSString *insertString = [NSString stringWithFormat:@"%@%@", 
                                  [tv currentLine],
                                  [tv lineEnding]];
        
        [tv replaceCharactersInRange:insertRange 
                          withString:insertString];
        
	}
}

@end

