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

/**
 * Register the plug-in with Coda.
 */
- (id)initWithPlugInController:(CodaPlugInsController*)inController bundle:(NSBundle*)aBundle
{
	if ((self = [super init]) != nil) {
        
		controller = inController;
	
        [controller
         registerActionWithTitle:NSLocalizedString(@"Duplicate Line Above", @"Duplicate Line Above submenu item")
         underSubmenuWithTitle:nil
         target:self
         selector:@selector(duplicateLineAbove:)
         representedObject:nil
         keyEquivalent:@"@y" // Cmd + Y
         pluginName:NSLocalizedString(@"Duplicate Line", @"Duplicate Line plugin name")];

        [controller
         registerActionWithTitle:NSLocalizedString(@"Duplicate Line Below", @"Duplicate Line Below submenu item")
         underSubmenuWithTitle:nil
         target:self
         selector:@selector(duplicateLineBelow:)
         representedObject:nil
         keyEquivalent:@"@Y" // Cmd + Shift + Y
         pluginName:NSLocalizedString(@"Duplicate Line", @"Duplicate Line plugin name")];
        
    }
    
	return self;
    
} // - initWithPlugInController:bundle:

/**
 * Provide a name for the plugin.
 */
- (NSString*)name
{
	return @"Duplicate Line";
} // - name

/**
 * Duplicate the current line of text before the current line.
 */
- (void)duplicateLineAbove:(id)sender
{
    
    // Get a proxy for the editor.
	CodaTextView *tv = [controller focusedTextView:self];
	
    if (tv) {

        // Read the range of the current line.
        NSRange currentLineRange = [tv rangeOfCurrentLine];
        
        // Prepare to insert before the current line.
        NSRange insertRange = {currentLineRange.location, 0};
        
        // Prepare to insert the current line and a line ending.
        NSString *insertString = [NSString stringWithFormat:@"%@%@", 
                                  [tv currentLine],
                                  [tv lineEnding]];
        
        // Insert the text.
        [tv replaceCharactersInRange:insertRange withString:insertString];
        
	}
    
} // - duplicateLineAbove:sender:

/**
 * Duplicate the current line of text after the current line.
 */
- (void)duplicateLineBelow:(id)sender
{
    
    // Get a proxy for the editor.
    CodaTextView *tv = [controller focusedTextView:self];
    
    if (tv) {
        
        // Find the location of the end of the current line.
        NSRange rcl = [tv rangeOfCurrentLine];
        NSInteger lineEndLocation = rcl.location + rcl.length;
        
        // Find the total length of the document.
        NSInteger totalLength = [[tv string] length];
        
        // Add the duplicate line. Take into account if this is the last
        // line in the editor.
        if (lineEndLocation >= totalLength) {
        
            // If the desired insert location is past the end, add a line 
            // ending followed by the duplicated line at last insertion point.
            
            // Prepare to insert after the current line.
            NSRange insertRange = {lineEndLocation, 0};
            
            // Prepare to insert the current line and a line ending.
            NSString *insertString = [NSString stringWithFormat:@"%@%@",
                                       [tv lineEnding],
                                       [tv currentLine]];
            
            // This insertion causes the cursor to move. To fix this, grab the
            // current selection and re-apply it after the insert.
            NSRange selectedRange = [tv selectedRange];
            
            // Insert the text.
            [tv replaceCharactersInRange:insertRange withString:insertString];
            
            // Reset the selection.
            [tv setSelectedRange:selectedRange];
            
        } else {

            // Otherwise, add the duplicated line followed by a line ending
            // after the insertion point at the end of the current line.

            //  Prepare to insert after the current line's line ending.
            NSRange insertRange = {
                lineEndLocation + [[tv lineEnding] length], 
                0
            };
            
            // Prepare to insert the current line and a line ending.
            NSString *insertString = [NSString stringWithFormat:@"%@%@", 
                                      [tv currentLine],
                                      [tv lineEnding]];
            
            // Insert the text.
            [tv replaceCharactersInRange:insertRange withString:insertString];
            
        }
        
    }    

} // - duplicateLineBelow:sender:

@end // DuplicateLinePlugIn

