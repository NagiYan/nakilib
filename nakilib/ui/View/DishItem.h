//
//  DishItem.h
//  HealthManagement
//
//  Created by Gareamac on 14-6-18.
//  Copyright (c) 2014年 Gareatech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishItem : UIView
{
    NSInteger _dishNameHeight;         // 菜名高度
    NSInteger _ingredientsHeight;      // 食材高度
    NSInteger _itemHeight;              // 总高
}

- (void)setContent:(NSString*)dishName foodIngredients:(NSArray*)ingredients dishType:(int)type;

- (NSInteger)getItemHeight:(NSString*)dishName foodIngredients:(NSArray*)ingredients;

@end
