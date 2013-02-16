//
//  SetCard.m
//  Matchismo
//
//  Created by Pappy on 2/14/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// ------ Class methods ----------------------------------------------------
+ (NSUInteger) maxNumber {
    return 3;
}

+ (NSArray *) validShadings {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *) validColors {
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *) validSymbols {
    return @[@"diamond", @"squiggle", @"oval"];
}
// -------------------------------------------------------------------------

// ------ Override super's method(s) ---------------------------------------
- (NSString *) contents {
    
    NSString *numberString = @[@"?", @"1", @"2", @"3"] [self.number]; // if number zero, show a "?"

    NSString *contents = [NSString stringWithFormat:@"%@ %@ %@ %@", numberString, self.shading, self.color, self.symbol];

    // if more than 1 symbol, make description plural
    if (self.number == 1) {
        return contents;
    } else {
        return [contents stringByAppendingString:@"s"];
    }
}

- (int) match:(NSArray *)otherCards {
    // match logic based on set game description found here: http://en.wikipedia.org/wiki/Set_(game)#Games
    int matchScore = 0; // 0 will mean "not a valid set", 1 will mean "is a valid set"
    
    if (otherCards.count == 2) { // if we're not comparing ourselves to exactly 2 other cards then cannot be a set
    
        int numberMatches = 0;
        int shadingMatches = 0;
        int colorMatches = 0;
        int symbolMatches = 0;
        
        for (id otherCard in otherCards) { // cycle thru other cards to look for matching attributes
            
            if (![otherCard isKindOfClass:[SetCard class]]) { // if other card not a "set card"...
                return 0; // then fall out since this cannot be a set
                
            } else {
                SetCard *otherSetCard = (SetCard *)otherCard;
                if (self.number == otherSetCard.number) numberMatches++;
                if ([self.shading isEqualToString:otherSetCard.shading]) shadingMatches++;
                if ([self.color isEqualToString:otherSetCard.color]) colorMatches++;
                if ([self.symbol isEqualToString:otherSetCard.symbol]) symbolMatches++;
            }
        }
        /*
         A set consists of three cards which satisfy all of these conditions:
           They all have the same number, or they have three different numbers.
           They all have the same symbol, or they have three different symbols.
           They all have the same shading, or they have three different shadings.
           They all have the same color, or they have three different colors.
        */
        if ((numberMatches == 0 || numberMatches == 2)
                && (shadingMatches == 0 || shadingMatches == 2)
                && (colorMatches == 0 || colorMatches == 2)
                && (symbolMatches == 0 || colorMatches == 2)) {
            matchScore = 1;
        }
        
    }
    
    return matchScore;
}
// -------------------------------------------------------------------------


// ------ Our property setters and getters ----------------------------------
- (void) setNumber:(NSUInteger)number {
    if (number >= 1 && number <= [SetCard maxNumber]) {
        _number = number;
    }
}


@synthesize shading = _shading; // we provide setter and getter
- (void) setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *) shading {
    return _shading ? _shading : @"?";
}


@synthesize color = _color; // we provide setter and getter
- (void) setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *) color {
    return _color ? _color : @"?";
}


@synthesize symbol = _symbol; // we provide setter and getter
- (void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *) symbol {
    return _symbol ? _symbol : @"?";
}
// ---------------------------------------------------------------------------

@end
