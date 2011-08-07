//
//  makePassword_DEMOAppDelegate.m
//  makePassword_DEMO
//
//  Created by hippos on 11/07/29.
//  Copyright 2011 hippos-lab.com All rights reserved.
//

#import "makePassword_DEMOAppDelegate.h"

int _mkpasswd(int argc, char *argv[]);

@implementation makePassword_DEMOAppDelegate

@synthesize window;
@synthesize indicator;
@synthesize passwd;
@synthesize slider;
@synthesize slide_value;
@synthesize number;
@synthesize special;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  
}

- (void)awakeFromNib
{
  [passwd setStringValue:@""];
  [slide_value setStringValue:@"0"];
  [slider setDoubleValue:0.0];
  [slider setTarget:self];
  [slider setAction:@selector(sliderMove:)];
  specialCharacters = [[NSMutableArray alloc] init];
  for(unsigned int c = 33 ; c < 127; c++)
  {
    if (((c >= 33 && c <=47) || (c >= 58 && c <=64) || (c >= 91 && c <=96) || (c >= 123 && c <=126)))
    [specialCharacters addObject:[NSNumber numberWithInteger:c]];
  }
  NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(handleSpecialCharacter:) name:@"ChangeSpecialCharacterNotify" object:nil];
}

-(IBAction)copy:sender
{
  NSPasteboard *generalPasteboard = [NSPasteboard generalPasteboard];
  [generalPasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
  [generalPasteboard setString:[passwd stringValue] forType:NSStringPboardType];
}

-(IBAction)sliderMove:(id)sender
{
  NSNumber* val = [NSNumber numberWithDouble:[slider doubleValue]];
  
  [slide_value setIntegerValue:[val integerValue]];
  [indicator setDoubleValue:[val integerValue]];
  
  if ([val integerValue] > 0)
  {
    BOOL n = [[NSNumber numberWithInteger:[number state]] boolValue];
    BOOL s = [[NSNumber numberWithInteger:[special state]] boolValue];    
    [passwd setStringValue:[self makepassWithNumber:n withSpecialChar:s]];
  }
  else
    [passwd setStringValue:@""];
}

- (IBAction)resetPassword:sender
{
  [passwd setStringValue:@""];
  [slide_value setStringValue:@"0"];
  [slider setDoubleValue:0.0];
  [indicator setDoubleValue:0.0];
}

- (NSString*)makepassWithNumber:(BOOL)withNumber withSpecialChar:(BOOL)withSpecialChar
{
  NSMutableString* password = [[NSMutableString alloc] initWithCapacity:20];
  NSUInteger passwdLength = [slide_value integerValue];
  while ([password length] < passwdLength) 
  {
    NSMutableString* rands = [NSMutableString stringWithString:[[NSNumber numberWithInt:rand()]stringValue]];
    while ([rands length] > 3) 
    {
      int c = 0;
      if (([[NSNumber numberWithChar:[rands characterAtIndex:0]] intValue] % 2) == 0)
      {
        c = [[rands substringWithRange:NSMakeRange(1,2)] intValue];
      }
      else
      {
        c = [[rands substringWithRange:NSMakeRange(1,3)] intValue];
      }
      if ([specialCharacters containsObject:[NSNumber numberWithInteger:c]] && withSpecialChar)
      {
        [password appendString:[NSString stringWithFormat:@"%c",c]];
      }
      else if ((c >= 48 && c <=57) && withNumber)
      {
        [password appendString:[NSString stringWithFormat:@"%c",c]];        
      }
      else if ((c >= 65 && c <=90) || (c >= 97 && c <=122))
      {
        [password appendString:[NSString stringWithFormat:@"%c",c]];        
      }
      [rands deleteCharactersInRange:NSMakeRange(0, 3)];      
    }
  }
  return password;
}

- (void)dealloc
{
  if (_preference) [_preference release];
  [super dealloc];
}

- (IBAction)showPreference:sender
{
  if (_preference == nil)
  {
    _preference = [[PreferenceWindowController alloc] initWithWindowNibName:@"Preference"];
  }
  [_preference loadWindow];
  [_preference setCharacters:specialCharacters];
  [_preference showPreference:[self window]];
}

-(void)handleSpecialCharacter:(NSNotification*)aNotification
{
  NSArray* characters = [aNotification object];
  [specialCharacters removeAllObjects];
  for(NSNumber* sc in characters)
  {
    [specialCharacters addObject:sc];
  }  
}

@end
