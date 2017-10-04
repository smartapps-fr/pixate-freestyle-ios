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
//  PXLexeme.m
//  Pixate
//
//  Modified by Anton Matosov on 12/30/15.
//  Created by Kevin Lindsey on 6/23/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXStylesheetLexeme.h"
#import "PXStylesheetTokenType.h"

@implementation PXStylesheetLexeme
{
    NSUInteger flags_;
}

@synthesize type = _type;
@synthesize text = _text;
@synthesize value = _value;
@synthesize range = _range;

#pragma mark - Static Initializers

+ (instancetype)lexemeWithType:(int)type
{
    return [[PXStylesheetLexeme alloc] initWithType:type withRange:NSMakeRange(NSNotFound, 0) withValue:nil];
}

+ (instancetype)lexemeWithType:(int)type withRange:(NSRange)range
{
    return [[PXStylesheetLexeme alloc] initWithType:type withRange:range withValue:nil];
}

+ (instancetype)lexemeWithType:(int)type withValue:(id)value
{
    return [[PXStylesheetLexeme alloc] initWithType:type withRange:NSMakeRange(NSNotFound, 0) withValue:value];
}

+ (instancetype)lexemeWithType:(int)type withRange:(NSRange)range withValue:(id)value
{
    return [[PXStylesheetLexeme alloc] initWithType:type withRange:range withValue:value];
}

#pragma mark - Initializers

- (instancetype)initWithType:(int)type text:(NSString *)text
{
    return [self initWithType:type withRange:NSMakeRange(NSNotFound, 0) withValue:text];
}

- (instancetype)initWithType:(int)aType withRange:(NSRange)aRange withValue:(id)aValue
{
    if (self = [super init])
    {
        _type = aType;
        _range = aRange;
        _value = aValue;
        flags_ = 0;
    }

    return self;
}

#pragma mark - Getters

- (NSString *)name
{
    //return [PXSSTokenType typeNameForInt:type];
    return [PXStylesheetTokenType typeNameForInt:_type];
}

#pragma mark - Methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@@%lu-%lu:«%@»", self.name, (unsigned long) _range.location, (unsigned long) _range.location + _range.length, _value];
}

#pragma mark - Flags

- (void)clearFlag:(int)type
{
    flags_ &= ~type;
}

- (void)setFlag:(int)type
{
    flags_ |= type;
}

- (BOOL)flagIsSet:(int)type
{
    return ((flags_ & type) == type);
}

@end
