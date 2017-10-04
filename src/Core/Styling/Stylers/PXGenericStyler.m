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
//  PXGenericStyler.m
//  Pixate
//
//  Modified by Anton Matosov on 12/30/15.
//  Created by Kevin Lindsey on 1/31/13.
//  Copyright (c) 2013 Pixate, Inc. All rights reserved.
//

#import "PXGenericStyler.h"

@implementation PXGenericStyler
{
    NSDictionary *handlers_;
}

- (instancetype)initWithHandlers:(NSDictionary *)handlers
{
    return [self initWithHandlers:handlers completionBlock:nil];
}

- (instancetype)initWithHandlers:(NSDictionary *)handlers completionBlock:(PXStylerCompletionBlock)block
{
    if (self = [super initWithCompletionBlock:block])
    {
        handlers_ = handlers;
    }

    return self;
}

- (NSDictionary *)declarationHandlers
{
    return handlers_;
}

@end
