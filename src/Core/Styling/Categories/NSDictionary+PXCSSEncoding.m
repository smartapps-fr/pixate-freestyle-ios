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
//  NSDictionary+PXCSSEncoding.m
//  Pixate
//
//  Modified by Anton Matosov on 12/30/15.
//  Created by Paul Colton on 12/18/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "NSDictionary+PXCSSEncoding.h"

void PXForceLoadNSDictionaryPXCSSEncoding() {}

@implementation NSDictionary (PXCSSEncoding)

- (NSString *)toCSS
{
    NSMutableArray* cssLine = [[NSMutableArray alloc] init];

    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [cssLine addObject:[NSString stringWithFormat:@"%@:%@;", key, obj]];
    }];

    return [cssLine componentsJoinedByString:@"\n"];
}

- (NSString *)toCSSWithKeys:(NSArray *)keys
{
    NSMutableArray* cssLine = [[NSMutableArray alloc] init];

    [keys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
        id object = self[key];

        if (object != nil)
        {
            [cssLine addObject:[NSString stringWithFormat:@"%@:%@;", key, object]];
        }
    }];

    return [cssLine componentsJoinedByString:@"\n"];
}

@end
