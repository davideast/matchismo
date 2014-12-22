//
//  ViewController.m
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) NSMutableArray *chosenCards; // of Card
@property (nonatomic, strong) NSString *chosenDescription;
@end

@implementation ViewController

static const int CHOSEN_DESCR_PICKED = 0;
static const int CHOSEN_DESCR_MATCHED = 1;
static const int CHOSEN_DESCR_MISMATCH = 2;

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

- (NSMutableArray*)chosenCards
{
  if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
  return _chosenCards;
}

- (Deck *)createDeck
{
  return [[PlayingCardDeck alloc] init];
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
  self.chosenDescription = self.game.chosenDescription;
  
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
