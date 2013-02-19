//
//  CardGame.m
//  Matchismo
//
//  Created by Pappy on 2/16/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()
@property (nonatomic, readwrite) BOOL matchWasTested;
@property (strong, nonatomic, readwrite) NSMutableArray *cardsTested;
@end

@implementation CardGame

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}

// Use lazy instantiation if cards array doesn't already exist
- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//
- (NSMutableArray *) cardsTested {
    if (!_cardsTested) _cardsTested = [[NSMutableArray alloc]init];
    return _cardsTested;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    
    self.matchWasTested = NO;
    
    self.resultMsg = nil;
    
    if (!card.isUnplayable) {
        card.faceUp = !card.isFaceUp;
    }

}

@end
