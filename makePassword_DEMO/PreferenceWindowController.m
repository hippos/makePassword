//
//  PreferenceWindowController.m
//  makePassword_DEMO
//
//  Created by hippos on 11/08/06.
//  Copyright 2011 hippos-lab.com. All rights reserved.
//

#import "PreferenceWindowController.h"


@implementation PreferenceWindowController

- (id)initWithWindow:(NSWindow *)window
{
  self = [super initWithWindow:window];
  if (self) 
  {
  }  
  return self;
}

- (void)awakeFromNib
{
}

- (void)dealloc
{
  [_specialCharacters release];
  [super dealloc];
}

- (void)windowDidLoad
{
  [super windowDidLoad];
}

- (IBAction)ok:sender
{
	[[self window] orderOut:sender];
	[NSApp endSheet:[self window] returnCode:0];
}

- (IBAction)cancel:sender
{
	[[self window] orderOut:sender];
	[NSApp endSheet:[self window] returnCode:1];
}

- (void)showPreference:(NSWindow*)modalWindow
{
  [NSApp beginSheet:[self window]
      modalForWindow:modalWindow 
        modalDelegate:self 
      didEndSelector:@selector(preferenceSheetDidEnd:returnCode:contextInfo:)
        contextInfo:nil];  
}

-(void)preferenceSheetDidEnd:(NSWindow*)sheet returnCode:(int)returnCode contextInfo:(void*)contextInfo
{
  if (returnCode == 0)
  {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeSpecialCharacterNotify" object:_specialCharacters];    
  }  
}

- (void)setCharacters:(NSArray*)characters
{
  if (_specialCharacters == nil)
  {
    _specialCharacters = [[NSMutableArray alloc] init];
  }
  [_specialCharacters removeAllObjects];
  for(NSNumber* c in characters)
  {
    [_specialCharacters addObject:c];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"SpecialCharacterNotify" object:_specialCharacters];
}

- (void)clickButton:(id)sender
{
  NSButton* sendbutton = (NSButton*)sender;
  
  if ([sendbutton state] == 1)
  {
    if (![_specialCharacters containsObject:[NSNumber numberWithInteger:[sendbutton tag]]])
    {
      [_specialCharacters addObject:[NSNumber numberWithInteger:[sendbutton tag]]];
    }
  }
  else
  {
    if ([_specialCharacters containsObject:[NSNumber numberWithInteger:[sendbutton tag]]])
    {
      [_specialCharacters removeObject:[NSNumber numberWithInteger:[sendbutton tag]]];
    }
  }
}

@end
