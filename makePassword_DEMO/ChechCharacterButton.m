//
//  ChechCharacterButton.m
//  makePassword_DEMO
//
//  Created by hippos on 11/08/06.
//  Copyright 2011 hippos-lab.com. All rights reserved.
//

#import "ChechCharacterButton.h"


@implementation ChechCharacterButton

- (id)init
{
  self = [super init];
  if (self) 
  {
  }
  
  return self;
}

- (void)awakeFromNib
{
  NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(handleSetState:) name:@"SpecialCharacterNotify" object:nil];
}

- (void)dealloc
{
  [super dealloc];
}

-(void)handleSetState:(NSNotification*)aNotification
{
  NSArray* characters = [aNotification object];
  if (characters != nil && [characters containsObject:[NSNumber numberWithInteger:[self tag]]])
  {
    [self setState:YES];
  }
  else
  {
    [self setState:NO];
  }
}

@end
