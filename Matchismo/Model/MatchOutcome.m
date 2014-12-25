//
//  MatchOutcome.m
//  Matchismo
//
//  Created by deast on 12/24/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "MatchOutcome.h"
#import "Card.h"

@implementation MatchOutcome


- (instancetype)initWithCards:(NSMutableArray *)cards :(Outcome)outcome
{
  self = [super init];
  
  if(self) {
    self.cardContents = [cards componentsJoinedByString:@","];
    self.outcome = outcome;
  }
  
  return self;
}

@end
