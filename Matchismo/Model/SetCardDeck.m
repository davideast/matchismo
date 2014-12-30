//
//  SetCardDeck.m
//  Matchismo
//
//  Created by deast on 12/30/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
  self = [super init];
  
  if (self) {
    
    for (NSString *color in [SetCard validColors]) {
      
      for (NSString *symbol in [SetCard validSymbols]) {
        
        for (NSString *shading in [SetCard validShadings]) {
          
          for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
            SetCard *card = [[SetCard alloc] init];
            card.color = color;
            card.symbol = symbol;
            card.shading = shading;
            card.number = number;
            [self addCard:card atTop:YES];
          }
          
        }
      }
    }
  }
  
  return self;
}

@end