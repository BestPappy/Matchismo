//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Pappy on 2/4/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *resultMsg;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) setThreeCardMatchMode:(BOOL)mode {
    _threeCardMatchMode = mode;
    // NSLog(@"threeCardMatchMode set to %u", _threeCardMatchMode);
}

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

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    
    self.resultMsg = nil;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {   //if card already faceUp, just flip it over...
            
            self.resultMsg = [@"Flipped up " stringByAppendingString:card.contents];
            
            if (!self.isThreeCardMatchMode) {
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
            } else {
                // ****** Logic for 3-card match game *****
                // count cards already faceUp and count how many match
                int faceUpCardCount = 0;
                int nbrMatched = 0;
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        faceUpCardCount++;
                        if ([card match:@[otherCard]]) nbrMatched++;
                    }
                }
                
                // if exactly 2 other cards faceUp && playable
                if (faceUpCardCount == 2) {

                    self.resultMsg=@"";
                    int scoreChange = 0;
                    
                    for (Card *otherCard in self.cards) {
                        
                        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                            self.resultMsg = [self.resultMsg stringByAppendingFormat:@"%@ & ", otherCard.contents];
                            
                            int matchScore = [card match:@[otherCard]];
                            if (matchScore && nbrMatched==2) {
                                otherCard.unplayable = YES;
                                card.unplayable = YES;
                                scoreChange += matchScore * MATCH_BONUS;
                            } else {
                                otherCard.faceUp = NO;
                                scoreChange -= MISMATCH_PENALTY;
                            }
                        }
                    }
                    
                    if (nbrMatched == 2) {
                        self.resultMsg = [self.resultMsg stringByAppendingFormat:@"%@ match for %d pts!",card.contents,scoreChange];
                    } else {
                        self.resultMsg = [self.resultMsg stringByAppendingFormat:@"%@ don't match. %d pt penalty!",card.contents,scoreChange];
                    }
                    self.score += scoreChange;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }

}

@end
