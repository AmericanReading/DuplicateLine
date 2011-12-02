//
//  DuplicateLinePlugin.h
//  Duplicate Line
//
//  Created by PJ Dietz on 12/2/11.
//  Copyright (c) 2011 American Reading Company. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CodaPluginsController.h"

@class CodaPlugInsController;

@interface DuplicateLinePlugIn : NSObject <CodaPlugIn>
{
	CodaPlugInsController* controller;
}

- (id)initWithPlugInController:(CodaPlugInsController*)controller bundle:(NSBundle*)aBundle;

@end
