//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by deast on 12/28/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *) createDeck
{
  return [[SetCardDeck alloc] init];
}

+ (NSDictionary *)validSymbols
{
  return @{
           @"triangle": @"▲",
           @"circle": @"●",
           @"square": @"■"
         };
}

+ (NSDictionary *)validColors
{
  return @{
           @"red": [UIColor redColor],
           @"green": [UIColor greenColor],
           @"purple": [UIColor purpleColor]
          };
}

// TODO: Keep cards face-down without attributed string showing through

// TODO: Maintain state of card image when flipping through the cards

- (NSAttributedString *)titleForCard:(Card *)card
{
  NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
  SetCard *setCard;
  
  if ([card isKindOfClass:[SetCard class]]) {
    setCard = (SetCard *)card;
    
    [attributes setObject:[SetCardGameViewController validColors][setCard.color]
                   forKey:NSForegroundColorAttributeName];
  }
  
  return [[NSAttributedString alloc] initWithString:setCard.symbol
                                                attributes:attributes];
}

@end