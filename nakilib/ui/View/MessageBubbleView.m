//
//  MessageBubbleView.m
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

#import "MessageBubbleView.h"
#import "CopyLabel.h"
#import "UIImage+Utils.h"
#import "GScreen.h"

//#define RIGHT_CONTENT_INSETS    UIEdgeInsetsMake(36, 3, 3, 17)
//#define LEFT_CONTENT_INSETS     UIEdgeInsetsMake(36, 17, 3, 3)

#define RIGHT_CONTENT_INSETS    UIEdgeInsetsMake(32, 35, 19, 35)
#define LEFT_CONTENT_INSETS     UIEdgeInsetsMake(32, 35, 19, 35)

static const float kBubbleTextSize = 17.0f;

@interface MessageBubbleView () <CopyLabelDelegate>

@property (nonatomic, assign) MessageBubbleViewTailDirection bubbleOrientation;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, retain) UIImageView *bubbleImageView;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, retain) CopyLabel *titleLabel;

@end

@implementation MessageBubbleView

- (id)initWithText:(NSString *)text withTailDirection:(MessageBubbleViewTailDirection)tailDirection;
{
    if( self = [super init] )
    {
        UIImageOrientation  bubbleOrientation;
        NSString*           baseImageFile = nil;
        
        _bubbleOrientation = tailDirection;
        
        if (tailDirection == MessageBubbleViewTailDirectionLeft)
        {
            _contentInsets = LEFT_CONTENT_INSETS;
            //bubbleOrientation =UIImageOrientationUpMirrored;
            bubbleOrientation =UIImageOrientationUp;
            baseImageFile = @"bg_chat_msg_gray.png";
        }
        else
        {
            _contentInsets = RIGHT_CONTENT_INSETS;
            bubbleOrientation =UIImageOrientationUp;
            baseImageFile = @"bg_chat_msg_green.png";
        }

        // bubble overlay image
        //UIImage *bubbleImage = [[UIImage imageWithCGImage:[UIImage imageNamed:baseImageFile].CGImage
        //                                            scale:1.0 orientation:bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        UIImage *bubbleImage = [[UIImage imageNamed:baseImageFile] resizableImageWithCapInsets:_contentInsets resizingMode:UIImageResizingModeStretch];
        
        _bubbleImageView = [[[UIImageView alloc] initWithImage:bubbleImage] autorelease];
        _bubbleImageView.frame = self.frame;
        _bubbleImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _titleLabel = [[[CopyLabel alloc] init] autorelease];
        _titleLabel.delegate = self;
        _titleLabel.text = text;
        _titleLabel.font = [UIFont systemFontOfSize:kBubbleTextSize];
        _titleLabel.textColor = UIColor.blackColor;
        
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.backgroundColor = UIColor.clearColor;
        
        //self.contentEdgeInsets = contentInsets;
        self.titleLabel.preferredMaxLayoutWidth = GScreenWidth*180/320.0;
        
        [self addSubview:_bubbleImageView];
        [self addSubview:_titleLabel];
        //[self autoresizesSubviews];
        self.backgroundColor = UIColor.clearColor;

    }
    return self;
}

#define TWO_THIRDS_OF_PORTRAIT_WIDTH (GScreenWidth * 0.66f)

- (void) sizeToFit
{
    [super sizeToFit];
    
    if( self.titleLabel.text )
    {
        self.frame = CGRectMake(0,0, self.textSize.width+35, self.textSize.height+20);
        self.titleLabel.frame = CGRectMake(0, 0, self.textSize.width, self.textSize.height);
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.titleLabel.text)
    {
        return self.textSize;
    }
    else
    {
        return self.imageSize;
    }
}

- (CGSize) textSize
{
    return [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:kBubbleTextSize]
                                           constrainedToSize:CGSizeMake(TWO_THIRDS_OF_PORTRAIT_WIDTH, INT_MAX)
                                               lineBreakMode:NSLineBreakByWordWrapping];
}

- (void) layoutSubviews
{
    [super layoutSubviews];

    if (self.titleLabel.text)
    {
        if( _bubbleOrientation == MessageBubbleViewTailDirectionRight )
            self.titleLabel.frame = CGRectMake(15, 5, self.textSize.width, self.textSize.height);
        else
            self.titleLabel.frame = CGRectMake(20, 5, self.textSize.width, self.textSize.height);
    }
}

- (id) initWithImage:(UIImage *)image
   withTailDirection:(MessageBubbleViewTailDirection) tailDirection
              atSize:(CGSize)size
{
    if (self = [super init])
    {
        self.imageSize = size;
        const UIEdgeInsets insets = UIEdgeInsetsMake(13, 13, 13, 21);
        
        //const UIImageOrientation bubbleOrientation = tailDirection ? UIImageOrientationUpMirrored : UIImageOrientationUp;
        const UIImageOrientation bubbleOrientation =  UIImageOrientationDownMirrored;
        
        const UIImage *resizableMaskImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"ImageBubbleMask~iphone"].CGImage
                                                                 scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        const UIImage *maskImageDrawnToSize = [resizableMaskImage renderAtSize:size];
        
        // bubble overlay image
        UIImage *bubbleImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"ImageBubble~iphone"].CGImage
                                                    scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:bubbleImage];
        
        // masked image
        //UIImageView *maskedImageView = [[UIImageView alloc] initWithImage:[image maskWithImage: maskImageDrawnToSize]];

        UIImageView *maskedImageView = [[UIImageView alloc] initWithImage:image];
        
        bubbleImageView.frame = maskedImageView.bounds;
        [self addSubview:maskedImageView];
        [self addSubview:bubbleImageView];
    }
    
    return self;
}

-(void) didStartSelect
{
}

-(void) didEndSelect
{

}

@end
