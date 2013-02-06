//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Pappy on 2/4/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@property (nonatomic, readonly) NSString *resultMsg;

@property (nonatomic, getter = isThreeCardMatchMode) BOOL threeCardMatchMode;

@end
