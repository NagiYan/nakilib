//
//  MJRefreshViewController.h
//  west dean delicious
//
//  Created by westonnaki on 15/9/8.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpBaseViewController.h"

@interface MJRefreshViewController : HttpBaseViewController

@property (retain, nonatomic) UITableView* tableView;

@property (retain, nonatomic) NSMutableArray* netData;

@property (assign, nonatomic) NSInteger currentPage;

@property (assign, nonatomic) NSInteger pageSize;

@property (assign, nonatomic) NSInteger index2oprate;
// 默认列表结束加end标志
@property (assign, nonatomic) BOOL hideEnd;

// 默认自动加载，这个是手动加载开关
@property (assign, nonatomic) BOOL manualLoad;

// 是否已全部加载完
@property (assign, nonatomic) BOOL noMoreData;

// 以下基本是必须调用的
// UI初始化
- (void)p_initMJRefreshUI;

// 处理网络收到的数据 请求到数据的回调需要调用, 处理数据
- (void)p_processData:(NSArray*)data;

// 结束刷新UI 请求到数据的回调需要调用，更新UI状态
- (void)p_stopReflash;

- (void)p_processDelete;

// 以下子类要实现--------------------
// 头刷新 请求数据 可选
- (void)p_loadDataNew;

// 尾刷新 请求数据 可选
- (void)p_loadDataNext;

// cell ui 在这里实现cell的UI
- (void)p_configCell:(UITableViewCell*)cell row:(NSInteger)row;


// 以下可选--------------------

// 数据是否变化， 用于头刷新，可实现数据比较，默认返回YES
- (BOOL)p_isDataChange:(NSArray*)data;

// 合并数据 默认头刷新替换全部，子类可细化
- (void)p_mergeData:(NSArray*)data;

- (void)p_didSelectRow:(NSIndexPath *)indexPath;
@end
