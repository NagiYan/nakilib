//
//  DishItem.m
//  HealthManagement
//
//  Created by Gareamac on 14-6-18.
//  Copyright (c) 2014年 Gareatech. All rights reserved.
//

#import "DishItem.h"
#import "GSizeUtil.h"

@implementation DishItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setContent:(NSString*)dishName foodIngredients:(NSArray*)ingredients dishType:(int)type
{
    int allwidth = [self frame].size.width/3;
    
    int word_top_space = 3;         // 字符上方留白
    int word_bottom_space = 3;      // 字符下方留白
    int word_front = 10;            // 字符前方留白
    int word_back  = 10;            // 字符后方留白
    int word_width = 14;            // 字符宽度
    int word_height = 17;           // 字符高度
    int width_dish  = allwidth;          // 菜名宽度
    int width_food  = allwidth;           // 食材宽度
    int width_quantity = allwidth;        // 食材量宽度
    NSInteger ingredientsHeight = 0;      // 食材高度
    
    
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
    int pos_dish_x = word_front;
    NSInteger pos_dish_y = _itemHeight/2 - (_dishNameHeight - word_top_space - word_bottom_space)/2;
    int dish_line_width = width_dish - word_front - word_back;  // 菜名可使用的宽度
    NSInteger dishLine = [dishName length] * word_width/dish_line_width + 1;    // 菜名需要几行
    
    // set dishname
    UILabel* dish = [[[UILabel alloc] initWithFrame:CGRectMake(pos_dish_x, pos_dish_y, dish_line_width, _dishNameHeight - word_top_space - word_bottom_space)] autorelease];
    
    [dish setText:dishName];
    [dish setFont:font];
    dish.numberOfLines = dishLine;
    dish.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    [self addSubview:dish];
    [dish setBackgroundColor:[UIColor clearColor]];
    //[dish release];

    
    NSInteger foodCount = ingredients.count;  // 食材个数
    for (int i = 0; i < foodCount; ++i)
    {
        NSString* foodName = [[ingredients objectAtIndex:i] objectForKey:@"materialName"];
        int food_line_width = width_food - word_front - word_back;  // 菜名可使用的宽度
        // 食材需要的行数
        NSInteger foodLine = [foodName length]*word_width/food_line_width + 1;
        // 该食材的总高
        NSInteger theFoodNameHeight = foodLine*word_height;
        
        NSInteger pos_food_x = width_dish + word_front;
        NSInteger pos_food_y = ingredientsHeight + word_top_space;
        // set food
        UILabel* food = [[[UILabel alloc] initWithFrame:CGRectMake(pos_food_x, pos_food_y, food_line_width, theFoodNameHeight)] autorelease];
        [food setText:foodName];
        [food setFont:font];
        food.numberOfLines = foodLine;
        food.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        [self addSubview:food];
        [food setBackgroundColor:[UIColor clearColor]];
        //[food release];
        
        NSInteger qty_int = [[[ingredients objectAtIndex:i] objectForKey:@"materialValue"] intValue];
        NSString* quantityStr = [NSString stringWithFormat:@"%ld", (long)qty_int];
        NSInteger pos_qty_x = width_dish + width_food + word_front;
        NSInteger pos_qty_y = ingredientsHeight + (theFoodNameHeight/2) - word_height/2 + word_top_space;
        // set qty
        UILabel* qty = [[[UILabel alloc] initWithFrame:CGRectMake(pos_qty_x, pos_qty_y, width_quantity - word_front - word_back, word_height)] autorelease];
        [qty setText:quantityStr];
        [qty setFont:font];
        [self addSubview:qty];
        [qty setBackgroundColor:[UIColor clearColor]];
        //[qty release];
        
        // 全部食材的累计高度
        ingredientsHeight = ingredientsHeight + theFoodNameHeight + word_top_space + word_bottom_space;
    }
}

- (NSInteger)getItemHeight:(NSString*)dishName foodIngredients:(NSArray*)ingredients
{
    int allwidth = [self frame].size.width/3;
    int word_top_space = 3;         // 字符上方留白
    int word_bottom_space = 3;      // 字符下方留白
    int word_front = 10;            // 字符前方留白
    int word_back  = 10;            // 字符后方留白
    int width_dish  = allwidth;          // 菜名宽度
    int width_food  = allwidth;           // 食材宽度
    //int width_quantity = 60;        // 食材量宽度
    
    NSInteger dishNameHeight = 0;         // 菜名高度
    NSInteger ingredientsHeight = 0;      // 食材高度
    
    dishNameHeight = [GSizeUtil getHeightForString:dishName withSysFontSize:14 maxWidth:(width_food - word_front - word_back)] + word_top_space + word_bottom_space + 1;
    
    NSInteger foodCount = ingredients.count;  // 食材个数
    for (int i = 0; i < foodCount; ++i)
    {
        NSString* foodName = [[ingredients objectAtIndex:i] objectForKey:@"materialName"];
        // 该食材的总高
        NSInteger theFoodNameHeight = [GSizeUtil getHeightForString:foodName withSysFontSize:14 maxWidth:(width_food - word_front - word_back)] + 1;
        // 全部食材的累计高度
        ingredientsHeight = ingredientsHeight + theFoodNameHeight + word_top_space + word_bottom_space;
    }
    
    // do pos set
    
    _dishNameHeight = dishNameHeight;         // 菜名高度
    _ingredientsHeight = ingredientsHeight;      // 食材高度
    
    _itemHeight = MAX(dishNameHeight, ingredientsHeight);
    return _itemHeight;
}

- (void)dealloc {
    [super dealloc];
}
@end
