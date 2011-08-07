//
//  PreferenceWindowController.h
//  makePassword_DEMO
//
//  Created by hippos on 11/08/06.
//  Copyright 2011 hippos-lab.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferenceWindowController.h"

@interface PreferenceWindowController : NSWindowController {
@private
  NSMutableArray* _specialCharacters;
    
}

- (IBAction)ok:sender;
- (IBAction)cancel:sender;
- (IBAction)clickButton:(id)sender;

- (void)showPreference:(NSWindow*)modalWindow;
- (void)setCharacters:(NSArray*)characters;

- (void)preferenceSheetDidEnd:(NSWindow*)sheet returnCode:(int)returnCode contextInfo:(void*)contextInfo;

@end
