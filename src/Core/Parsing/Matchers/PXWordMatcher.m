/*
 * Copyright 2012-present Pixate, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  PXWordMatcher.m
//  Pixate
//
//  Modified by Anton Matosov on 12/30/15.
//  Created by Kevin Lindsey on 6/25/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXWordMatcher.h"

@implementation PXWordMatcher
{
    NSRegularExpression *pattern;
    NSDictionary *wordMap;
}

#pragma mark - Initializers
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    return [self initWithDictionary:dictionary usingSymbols:NO];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary usingSymbols:(BOOL)usingSymbols
{
    if (self = [super init])
    {
        NSString *patternString = nil;

        if (dictionary)
        {
            NSArray *keys = dictionary.allKeys;
            NSString *joinedKeys = [NSString stringWithFormat:@"\\Q%@\\E", [keys componentsJoinedByString:@"\\E|\\Q"]];
            NSString *closingRegex = (usingSymbols) ? @")" : @")\\b";

            patternString = [[@"^(?:" stringByAppendingString:joinedKeys] stringByAppendingString:closingRegex];

            if (self = [super initWithType:0 withPatternString:patternString])
            {
                self->wordMap = [NSDictionary dictionaryWithDictionary:dictionary];
            }
        }
    }

    return self;
}

#pragma mark - PXSLexemeCreator implementation

- (PXStylesheetLexeme *)createLexemeWithString:(NSString *)aString withRange:(NSRange)aRange
{
    PXStylesheetLexeme *match = [super createLexemeWithString:aString withRange:aRange];
    PXStylesheetLexeme *result = nil;

    if (wordMap && match)
    {
        NSString *text = [aString substringWithRange:match.range];
        NSNumber *type = wordMap[text];

        if (type)
        {
            result = [PXStylesheetLexeme lexemeWithType:type.intValue withRange:match.range withValue:text];
        }
    }

    return result;
}

@end
