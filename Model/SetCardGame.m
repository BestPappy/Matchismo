//
//  SetCardGame.m
//  Matchismo
//
//  Created by Pappy on 2/16/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()
@property (nonatomic, readwrite) BOOL matchWasTested;
@property (strong, nonatomic, readwrite) NSMutableArray *cardsTested;
@end


@implementation SetCardGame

- (void)flipCardAtIndex:(NSUInteger)index {
    
    self.matchWasTested=NO;
    [self.cardsTested removeAllObjects];
    
    // get the card to be acted upon
    Card *card = [self cardAtIndex:index];
    
    // if it is not already faceup...
    if (!card.isFaceUp) {
        // build an array of any other faceup cards to compare it to
        NSMutableArray *otherCards = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.cards.count; i++) {
            if (i != index) { // skip the card we're acting upon
                if (![self cardAtIndex:i].isUnplayable && [self cardAtIndex:i].isFaceUp) {
                    [otherCards addObject:[self cardAtIndex:i]];
                }
            }
        }
        // if we found 2 other faceup cards, check for a set...
        if (otherCards.count == 2) {
            self.matchWasTested = YES;
            [self.cardsTested addObjectsFromArray:otherCards];
            [self.cardsTested addObject:card];
            
            int matchScore = [card match:otherCards];
            if (matchScore) {
                for (Card *otherCard in otherCards) {
                    otherCard.unplayable = YES;
                    otherCard.faceUp = NO;
                }
                card.unplayable = YES;
                self.score += matchScore;
            } else {
                for (Card *otherCard in otherCards) {
                    otherCard.faceUp = NO;
                }
                self.score -=1;                
            }
        }
    }
    
    if (!card.isUnplayable) {
        card.faceUp = !card.isFaceUp;
    }
    
}

@end
