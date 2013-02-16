//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Pappy on 2/3/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) UIImage *cardBackImage;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation CardGameViewController

- (UIImage *) cardBackImage {
    if (!_cardBackImage) {
        _cardBackImage = [[UIImage alloc] initWithContentsOfFile:@"/Users/Pappy/Developer/Matchismo/Matchismo/CardBack.jpg"];
    }
    return _cardBackImage;
}

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    
    return _game;
}

- (void) setCardButtons: (NSArray *) cardButtons {
    _cardButtons = cardButtons;
    
    //for (UIButton *cardButton in cardButtons) {
    //    Card *card = [self.deck drawRandomCard];
    //    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    //}
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        if (cardButton.selected) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:self.cardBackImage forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.game.score];
    self.msgLabel.text = self.game.resultMsg;
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
    self.msgLabel.text = @"New game. Tap a card to flip it!";
}
























@end
