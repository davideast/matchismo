//
//  NSObject+CardMatchingGame.m
//  Matchismo
//
//  Created by deast on 12/16/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int CARDS_TO_CHOOSE = 3;
static const int CHOSEN_DESCR_PICKED = 0;
static const int CHOSEN_DESCR_MATCHED = 1;
static const int CHOSEN_DESCR_MISMATCH = 2;

- (NSMutableArray*)cards
{
  if(!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
  self = [super init];
    
  if (self) {
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
    
  }
    
  return self;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
  Card *card = [self cardAtIndex:index];
  NSMutableArray *pickedCards = [[NSMutableArray alloc] init];
  
  if(!card.isMatched) {
    
    if(card.isChosen) {
      // set chosen to NO, making it flip face down
      card.chosen = NO;
    } else {
      // matches against another card
      for(Card *otherCard in self.cards) {
        
        if(otherCard.isChosen && !otherCard.isMatched) {
          [pickedCards addObject: otherCard];
        }
        
      }
      
      NSUInteger chosenCardCount = [pickedCards count];
      if(chosenCardCount == (CARDS_TO_CHOOSE - 1)) {
        [self checkCardMatchForCards:card :pickedCards];
      } else {
        card.chosen = YES;
      }
  
      // penalty for every flip of a card
      self.score -= COST_TO_CHOOSE;
    }
  }
}

- (void)checkCardMatchForCards:(Card*)card :(NSMutableArray *)pickedCards
{
  int matchScore = [card match:pickedCards];
  if(matchScore) {
    self.score += matchScore * MATCH_BONUS;
    // Set all cards matched = YES
    [pickedCards addObject:card];
    [self setMatchForCards:pickedCards :YES];
    [self setChosenForCards:pickedCards: YES];
    [self changeChosenDescriptionForCards:pickedCards :CHOSEN_DESCR_MATCHED];
  } else {
    // Set all cards chosen = NO
    [self setChosenForCards:pickedCards :NO];
    [self changeChosenDescriptionForCards:pickedCards :CHOSEN_DESCR_MISMATCH];
    self.score -= MISMATCH_PENALTY;
  }
  
}

- (void)changeChosenDescriptionForCards:(NSMutableArray *)cards :(int)type
{
  NSString *cardsString = [cards componentsJoinedByString:@","];
  NSString *description = @"";
  
  switch (type) {
    // Picked card
    case CHOSEN_DESCR_PICKED:
      description = @"%@";
      break;
    // Matched cards
    case CHOSEN_DESCR_MATCHED:
      description = @"Matched %@";
      break;
    // Mistmatch cards
    case CHOSEN_DESCR_MISMATCH:
      description = @"Mistmatch of %@";
    // Unknown
    default:
      description = @"";
      break;
  }
  
  self.chosenDescription = [NSString stringWithFormat:description, cardsString];
}

- (void)setMatchForCards:(NSMutableArray*)cards :(BOOL)isMatched
{
  for (Card *card in cards){
    card.matched = isMatched;
  }
}

- (void)setChosenForCards:(NSMutableArray*)cards :(BOOL)isChosen
{
  for (Card *card in cards){
    card.chosen = isChosen;
  }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
  return nil;
}


@end
