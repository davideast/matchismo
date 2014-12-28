//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by deast on 12/16/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) MatchOutcome *lastOutcome;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int CARDS_TO_CHOOSE = 3;

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
        // there was no outcome
        [pickedCards addObject:card];
        self.lastOutcome = [[MatchOutcome alloc] initWithCards:pickedCards :OutcomePicked];
      }
  
      // penalty for every flip of a card
      self.score -= COST_TO_CHOOSE;
    }
  }
}

- (void)checkCardMatchForCards:(Card*)card :(NSMutableArray *)pickedCards
{
  // store the previous match score
  int matchScore = [card match:pickedCards];
  [pickedCards addObject:card];
  if(matchScore) {
    self.score += matchScore * MATCH_BONUS;
    // Set all cards matched = YES
    [self setMatchForCards:pickedCards :YES];
    [self setChosenForCards:pickedCards: YES];
    self.lastOutcome = [[MatchOutcome alloc] initWithCards:pickedCards :OutcomeMatch];
  } else {
    // Set all cards chosen = NO
    [self setChosenForCards:pickedCards :NO];
    self.score -= MISMATCH_PENALTY;
    self.lastOutcome = [[MatchOutcome alloc] initWithCards:pickedCards :OutcomeMismatch];
  }
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
