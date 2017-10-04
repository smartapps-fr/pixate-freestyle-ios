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
//  PXUIView.m
//  Pixate
//
//  Modified by Anton Matosov on 12/30/15.
//  Created by Paul Colton on 9/13/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXUIView.h"
#import <QuartzCore/QuartzCore.h>

#import "UIView+PXStyling.h"
#import "UIView+PXStyling-Private.h"
#import "PXStylingMacros.h"
#import "PXStyleUtils.h"
#import "NSMutableDictionary+PXObject.h"
#import "NSDictionary+PXObject.h"
#import "PXVirtualStyleableControl.h"

#import "PXOpacityStyler.h"
#import "PXLayoutStyler.h"
#import "PXTransformStyler.h"
#import "PXShapeStyler.h"
#import "PXFillStyler.h"
#import "PXBorderStyler.h"
#import "PXBoxShadowStyler.h"
#import "PXAnimationStyler.h"
#import "PXPaintStyler.h"

static const char STYLE_CHILDREN;

@implementation PXUIView

+ (void)initialize
{
    if (self != PXUIView.class)
        return;
    
    [UIView registerDynamicSubclass:self withElementName:@"view"];
}

- (NSArray *)pxStyleChildren
{
    NSArray *styleChildren;
    
    if (!objc_getAssociatedObject(self, &STYLE_CHILDREN))
    {
        __weak PXUIView* weakSelf = self;

        //
        // layer
        //
        PXVirtualStyleableControl *layer = [[PXVirtualStyleableControl alloc] initWithParent:self elementName:@"layer" viewStyleUpdaterBlock:^(PXRuleSet *ruleSet, PXStylerContext *context) {
            if (context.usesColorOnly)
            {
                weakSelf.px_layer.backgroundColor = context.color.CGColor;
            }
            else if (context.usesImage)
            {
                weakSelf.px_layer.contents = (__bridge id)(context.backgroundImage.CGImage);
            }
        }];

        layer.viewStylers = @[
                              PXShapeStyler.sharedInstance,
                              PXFillStyler.sharedInstance,
                              PXBorderStyler.sharedInstance,
                              PXBoxShadowStyler.sharedInstance
                              ];

        styleChildren = @[ layer ];
        
        objc_setAssociatedObject(self, &STYLE_CHILDREN, styleChildren, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return [objc_getAssociatedObject(self, &STYLE_CHILDREN) arrayByAddingObjectsFromArray:self.subviews];
}


- (NSArray *)viewStylers
{
    static __strong NSArray *stylers = nil;
	static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        stylers = @[
            PXTransformStyler.sharedInstance,
            PXLayoutStyler.sharedInstance,
            PXOpacityStyler.sharedInstance,

            PXShapeStyler.sharedInstance,
            PXFillStyler.sharedInstance,
            PXBorderStyler.sharedInstance,
            PXBoxShadowStyler.sharedInstance,

            PXAnimationStyler.sharedInstance,
            
            PXPaintStyler.sharedInstanceForTintColor,
        ];
    });

	return stylers;
}

- (NSDictionary *)viewStylersByProperty
{
    static NSDictionary *map = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        map = [PXStyleUtils viewStylerPropertyMapForStyleable:self];
    });

    return map;
}

- (void)updateStyleWithRuleSet:(PXRuleSet *)ruleSet context:(PXStylerContext *)context
{
    if (context.usesColorOnly)
    {
        [self px_setBackgroundColor: context.color];
    }
    else if (context.usesImage)
    {
        [self px_setBackgroundColor: [UIColor colorWithPatternImage:context.backgroundImage]];
    }
}

- (BOOL)preventStyling
{
    return [self.superview isKindOfClass:[UITextView class]];
}

// Px Wrapped Only
PX_PXWRAP_PROP(CALayer, layer);

// Ti Wrapped
PX_WRAP_1(setBackgroundColor, color);
PX_WRAP_1(setTintColor, color);

// Styling
PX_LAYOUT_SUBVIEWS_OVERRIDE

@end
