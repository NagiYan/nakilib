//
//  PooCodeView.m
//  Code
//
//  Created by crazypoo on 14-4-14.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooCodeView.h"

@implementation PooCodeView
@synthesize changeArray = _changeArray;
@synthesize changeString = _changeString;
@synthesize codeLabel = _codeLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.cornerRadius = 3.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];

        [self setCodeLength:4];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateCode:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGestureRecognizer];
        
        //[self change];
    }
    return self;
}

-(void)updateCode:(UITapGestureRecognizer*)tap
{
    [self update];
}

- (void)update
{
    [self change];
    [self setNeedsDisplay];
}

- (void)change
{
    switch ([self codeType])
    {
        case CODE_TYPE_NUMBER:
            self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
            break;
        case CODE_TYPE_ALPHA:
            self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
            break;
        default:
            break;
    }
    
    [self setChangeString:[NSMutableString new]];

    for(NSInteger i = 0; i < [self codeLength]; i++)
    {
        NSInteger index = arc4random() % ([self.changeArray count] - 1);
        NSString* getStr = [self.changeArray objectAtIndex:index];
        
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([self.changeArray count] == 0)
        return;
//    float red = arc4random() % 100 / 100.0;
//    float green = arc4random() % 100 / 100.0;
//    float blue = arc4random() % 100 / 100.0;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

    [self setBackgroundColor:[UIColor whiteColor]];

    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20], NSFontAttributeName, [UIColor colorWithWhite:0 alpha:1], NSForegroundColorAttributeName ,nil];
    CGSize cSize = [@"S" sizeWithAttributes:attributes];
    NSInteger perWidth = rect.size.width / text.length;
    int width = MAX(1, perWidth - cSize.width);
    int height = rect.size.height - cSize.height;
    CGPoint point;

    float pX, pY;
    for (int i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + perWidth * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withAttributes:attributes];
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int cout = 0; cout < 10; cout++)
    {
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor* color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}
@end
