//
//  SetCard.h
//  Matchismo
//
//  Created by Pappy on 2/14/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number; // 1, 2, or 3
@property (strong, nonatomic) NSString *shading; // solid, striped, or open
@property (strong, nonatomic) NSString *color; // red, green, or purple
@property (strong, nonatomic) NSString *symbol; // diamond, squiggle, or oval

+ (NSUInteger)maxNumber;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;
+ (NSArray *)validSymbols;

@end
