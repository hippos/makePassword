//
//  makePassword_DEMOAppDelegate.h
//  makePassword_DEMO
//
//  Created by hippos on 11/07/29.
//  Copyright 2011 hippos-lab.com All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferenceWindowController.h"

@interface makePassword_DEMOAppDelegate : NSObject <NSApplicationDelegate> {
@private
  NSWindow *window;
  NSLevelIndicator* indicator;
  NSTextField* passwd;
  NSTextField* slide_value;
  NSSlider* slider;
  NSButton* number;
  NSButton* special;
  PreferenceWindowController* _preference;
  NSMutableArray* specialCharacters;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSLevelIndicator *indicator;
@property (assign) IBOutlet NSTextField *passwd;
@property (assign) IBOutlet NSTextField *slide_value;
@property (assign) IBOutlet NSSlider *slider;
@property (assign) IBOutlet NSButton *number;
@property (assign) IBOutlet NSButton *special;

- (IBAction)copy:sender;
- (IBAction)resetPassword:sender;
- (IBAction)showPreference:sender;
- (NSString*)makepassWithNumber:(BOOL)withNumber withSpecialChar:(BOOL)withSpecialChar;
@end
