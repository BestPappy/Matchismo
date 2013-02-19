//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Pappy on 2/12/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setCardButtons;

@property (strong, nonatomic) SetCardGame *game;

@property (nonatomic) int flipCount;

@end

@implementation SetGameViewController

- (SetCardGame *) game {
    if (!_game) { // use lazy instantiation if necessary
        _game = [[SetCardGame alloc] initWithCardCount:self.setCardButtons.count
                                             usingDeck:[[SetCardDeck alloc] init]];
        //NSLog(@"Game initialized.");
    }
    
    return _game;
}

- (IBAction)reDeal {
    self.game = nil; // force instantiation of a new game
    self.flipCount = 0;
    [self updateUI];
    self.resultLabel.text = @"Set Cards Re-Dealt";
}

- (IBAction)setCardTapped:(UIButton *)sender {
    int prevScore = self.game.score;
    [self.game flipCardAtIndex:[self.setCardButtons indexOfObject:sender]];
    //*******************************************
    //* add code to build result message here!! *
    NSMutableAttributedString *msg = nil;
    if (!self.game.matchWasTested) {
        SetCard *card =(SetCard *) [self.game cardAtIndex:[self.setCardButtons indexOfObject:sender]];
        if (card.isFaceUp) {
            msg = [[self formattedContents:card] mutableCopy];
            [msg appendAttributedString:[[NSAttributedString alloc]initWithString:@" selected"]];
        } else {
            msg = [[self formattedContents:card] mutableCopy];
            [msg appendAttributedString:[[NSAttributedString alloc]initWithString:@" de-selected"]];
        }
    } else {
        SetCard *card = (SetCard *) self.game.cardsTested[0];
        msg = [[self formattedContents:card] mutableCopy];
        [msg appendAttributedString:[[NSAttributedString alloc]initWithString:@"&"]];
        card = (SetCard *) self.game.cardsTested[1];
        [msg appendAttributedString:[self formattedContents:card]];
        [msg appendAttributedString:[[NSAttributedString alloc]initWithString:@"&"]];
        card = (SetCard *) self.game.cardsTested[2];
        [msg appendAttributedString:[self formattedContents:card]];
        if ((self.game.score - prevScore) > 0) {
            [msg appendAttributedString:[[NSAttributedString alloc]initWithString:@" make a set!"]];
        } else {
            [msg appendAttributedString:[[NSAttributedString alloc]initWithString:@" don't make a set!"]];
        }

    }
    self.resultLabel.attributedText = msg;
    //*******************************************
    self.flipCount++;
    [self updateUI];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void) updateUI {
    for (int index = 0; index < self.setCardButtons.count; index++) {
        SetCard *card =(SetCard *) [self.game cardAtIndex:index];
        UIButton *btn = [self.setCardButtons objectAtIndex:index];
        
        [btn setAttributedTitle:[self formattedContents:card] forState:UIControlStateNormal];
        
        // set the button's selected state to reflect whether the card is "faceup"
        btn.selected = card.isFaceUp;
        if (btn.selected) {
            [btn setBackgroundColor:[UIColor colorWithRed:0.8
                                                    green:0.8
                                                     blue:1.0
                                                    alpha:1.0]];
        } else {
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    
        // if the card is unplayable, then hide it's button
        [btn setHidden:card.isUnplayable];
        
    }
    
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
}

- (NSAttributedString *) formattedContents: (SetCard *)card {
    
    UIColor *symbolColor = nil;
    if ([card.color isEqualToString:@"red"]) {
        symbolColor = [UIColor redColor];
    } else {
        if ([card.color isEqualToString:@"green"]) {
            //symbolColor = [UIColor greenColor];
            symbolColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
        } else {
            if ([card.color isEqualToString:@"purple"]) {
                symbolColor = [UIColor purpleColor];
            }
        }
    }
    
    float alphaValue = 0.0; // "open" shading
    if ([card.shading isEqualToString:@"solid"]) {
        alphaValue = 1.0;
    } else {
        if ([card.shading isEqualToString:@"striped"]) {
            alphaValue = 0.25;
        }
    }
    
    // build the attributed string for the button's title
    NSString *symbolString = nil;
    if ([card.symbol isEqualToString:@"diamond"]) {
        symbolString = [@"■■■" substringWithRange:NSMakeRange(0, card.number)];
    } else if ([card.symbol isEqualToString:@"oval"]) {
        symbolString = [@"●●●" substringWithRange:NSMakeRange(0, card.number)];
    } else if ([card.symbol isEqualToString:@"squiggle"]) {
        symbolString = [@"▲▲▲" substringWithRange:NSMakeRange(0, card.number)];
    }
    
    NSDictionary *attribs = @{NSForegroundColorAttributeName:[symbolColor
                                                              colorWithAlphaComponent:alphaValue],
                              NSStrokeWidthAttributeName:@-10,
                              NSStrokeColorAttributeName:symbolColor};
    
    return [[NSAttributedString alloc] initWithString:symbolString attributes:attribs];

}

@end
