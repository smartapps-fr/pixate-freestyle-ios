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
//  PXBorderInfo.m
//  Pixate
//
//  Modified by Anton Matosov on 12/30/15.
//  Created by Kevin Lindsey on 3/25/13.
//  Copyright (c) 2013 Pixate, Inc. All rights reserved.
//

#import "PXBorderInfo.h"

@implementation PXBorderInfo

#pragma mark - Initializers

- (instancetype)init
{
    return [self initWithPaint:nil width:0.0f style:PXBorderStyleNone];
}

- (instancetype)initWithPaint:(id<PXPaint>)paint width:(CGFloat)width
{
    return [self initWithPaint:paint width:width style:PXBorderStyleSolid];
}

- (instancetype)initWithPaint:(id<PXPaint>)paint width:(CGFloat)width style:(PXBorderStyle)style
{
    if (self = [super init])
    {
        _paint = paint;
        _width = width;
        _style = style;
    }

    return self;
}

#pragma mark - Getters

- (BOOL)isOpaque
{
    // TODO: take border style into account

    return
        _width == 0.0f
    ||  (_paint != nil && _paint.isOpaque);
}

- (BOOL)hasContent
{
    return
        _width > 0.0f
    &&  _style != PXBorderStyleNone
    &&  _style != PXBorderStyleHidden
    &&  _paint != nil;
}

@end
