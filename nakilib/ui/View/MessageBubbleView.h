//
//  MessageBubbleView.h
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum
{
    MessageBubbleViewTailDirectionRight = 0,
    MessageBubbleViewTailDirectionLeft = 1
} MessageBubbleViewTailDirection;


@interface MessageBubbleView : UIView

- (id)initWithText:(NSString *)text withTailDirection:(MessageBubbleViewTailDirection)tailDirection;

- (id)initWithImage:(UIImage *)image withTailDirection:(MessageBubbleViewTailDirection)tailDirection atSize:(CGSize) size;

@end
