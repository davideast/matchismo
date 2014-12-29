//
//  ViewController.m
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "Outcome.h"
#import "MatchOutcome.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) NSString *chosenDescription;
@end

@implementation CardGameViewController

- (Deck *)deck
{
  if(!_deck) _deck = [self createDeck];
  return _deck;
}

- (CardMatchingGame *)game
{
  if(!_game) _game = [self createGame];
  return _game;
}

- (void)setChosenDescription:(NSString *)chosenDescription
{
  _chosenDescription = chosenDescription;
  [self.descriptionLabel setText:chosenDescription];
}

- (Deck *)createDeck // abstract
{
  return nil;
}

- (CardMatchingGame *)createGame
{
  return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                           usingDeck:[self createDeck]];
}

- (IBAction)dealAgain:(UIButton *)sender {
  self.game = [self createGame];
  [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
  NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];
}

- (void)updateUI
{
  for (UIButton* cardButton in self.cardButtons) {
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
    
    Card *card = [self.game cardAtIndex:cardIndex];
    
    [cardButton setTitle:[self titleForCard:card]
                forState:UIControlStateNormal];
    
    [cardButton setBackgroundImage:[self imageForCard:card]
                          forState:UIControlStateNormal];
    
    cardButton.enabled = !card.isMatched;
  }
  [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld", (long)self.game.score]];
  NSLog(@"%@", self.game.lastOutcome.cardContents);
  NSString *chosenDescr = [self changeChosenDescriptionForMatchOutcome:self.game.lastOutcome];
  self.chosenDescription = chosenDescr;
}

- (NSString *)changeChosenDescriptionForMatchOutcome:(MatchOutcome *)outcome
{
  
  NSString *description = @"";
  
  switch (outcome.outcome) {
      // Picked card
    case OutcomePicked:
      description = @"%@";
      break;
      // Matched cards
    case OutcomeMatch:
      description = @"Matched %@";
      break;
      // Mistmatch cards
    case OutcomeMismatch:
      description = @"Mismatch of %@";
      break;
      // Unknown
    default:
      description = @"";
      break;
  }
  
  return [NSString stringWithFormat:description, outcome.cardContents];
}

- (NSString *)titleForCard:(Card *)card
{
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)imageForCard:(Card *)card
{
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
