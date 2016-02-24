//
//  MultipleMJRefreshViewController.h
//  west dean delicious
//
//  Created by westonnaki on 15/9/28.
//  Copyright © 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleMJRefreshViewController : UIViewController

@property (retain, nonatomic) NSMutableArray* tableViews;

// UI初始化 top 标高顶部坐标，默认64
- (void)p_initMJRefreshUITableCount:(NSInteger)count top:(NSInteger)top;

// 显示某个表格
- (void)p_showTableView:(NSInteger)index;

// 处理网络收到的数据
- (void)p_processData:(NSArray*)data forIndex:(NSInteger)index;

// 处理删除操作
- (void)p_processDeleteForIndex:(NSInteger)index;

// 结束刷新UI
- (void)p_stopReflash;

#pragma mark - 数据存取
- (UITableView*)getTableView:(NSInteger)index;

// 获取网络数据
- (NSMutableArray*)netdata:(NSInteger)index;
// 设置网络数据
- (void)setNetData:(NSArray*)data forIndex:(NSInteger)index;
// 获取页面加载大小
- (NSInteger)pageSizeForIndex:(NSInteger)index;
// 设置页面加载大小
- (void)setPageSize:(NSInteger)size forIndex:(NSInteger)index;
// 获取页码
- (NSInteger)pageNoForIndex:(NSInteger)index;
// 设置页码
- (void)setPageNo:(NSInteger)num forIndex:(NSInteger)index;
// 获取要操作的行号
- (NSInteger)index2oprateForIndex:(NSInteger)index;
// 设置要操作的行号
- (void)setIndex2oprate:(NSInteger)no forIndex:(NSInteger)index;

#pragma mark - 子类重载
// condition
- (void)p_loadDataNew:(NSInteger)index;
// condition
- (void)p_loadDataNext:(NSInteger)index;
// required
- (void)p_configCell:(UITableViewCell*)cell row:(NSInteger)row forTableIndex:(NSInteger)index;
// optional
- (void)p_didSelectRow:(NSIndexPath *)indexPath inTableView:(NSInteger)index;
// optional
- (BOOL)p_isDataChange:(NSArray*)data index:(NSInteger)index;

// 返回当前选中的表格序号
- (NSInteger)p_getCurrentIndex;
@end
