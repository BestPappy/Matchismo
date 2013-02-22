//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Pappy on 2/4/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@implementation CardMatchingGame

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

// override the trivial version of the method contained in CardGame...
- (void)flipCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    
    self.resultMsg = nil;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {   //if card already faceUp, just flip it over...
            
            self.resultMsg = [@"Flipped up " stringByAppendingString:card.contents];
            
            // see if flipping this card up creates a 2-card match
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.resultMsg = [NSString stringWithFormat:@"Matched %@ with %@ for %d points!",card.contents,otherCard.contents,matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.resultMsg = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }

}

@end
