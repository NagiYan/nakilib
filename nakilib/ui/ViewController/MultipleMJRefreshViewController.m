//
//  MultipleMJRefreshViewController.m
//  west dean delicious
//
//  Created by westonnaki on 15/9/28.
//  Copyright © 2015年 westonnaki. All rights reserved.
//

#import "MultipleMJRefreshViewController.h"
#import "MJRefresh.h"
#import "MGSwipeTableCell.h"
#import "Masonry.h"

static NSString* identifier = @"mmjrefresh_cell";

@interface MultipleMJRefreshViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MultipleMJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)p_initMJRefreshUITableCount:(NSInteger)count top:(NSInteger)top
{
     [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    _tableViews = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (int i = 0; i < count; ++i)
    {
        // tableview
        UITableView* tableView = [UITableView new];
        [[self view] addSubview:tableView];
        [tableView setTag:i];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(top);
        }];
        tableView.tableFooterView = [UIView new];

        __block typeof(self) weakSelf = self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf onHeaderReflash:tableView.mj_header];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf onFooterReflash:tableView.mj_footer];
        }];
        [tableView registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:identifier];
        [tableView.mj_header setTag:i];
        [tableView.mj_footer setTag:i];
        
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        NSMutableDictionary* singleTableView = [[NSMutableDictionary alloc] initWithCapacity:0];
        [singleTableView setObject:tableView forKey:@"tableView"];
        [singleTableView setObject:@20 forKey:@"pageSize"];
        [singleTableView setObject:@0 forKey:@"currentPage"];
        [singleTableView setObject:[NSMutableArray arrayWithCapacity:0] forKey:@"netData"];
        [singleTableView setObject:@YES forKey:@"loadNew"];
        [singleTableView setObject:@0 forKey:@"index2oprate"];
        [_tableViews addObject:singleTableView];
    }
}

- (void)onHeaderReflash:(id)sender
{
    NSInteger index = [sender tag];
    [self setLoadNew:YES forIndex:index];
    [self p_loadDataNew:index];
}

- (void)onFooterReflash:(id)sender
{
    NSInteger index = [sender tag];
    [self setLoadNew:NO forIndex:index];
    [self p_loadDataNext:index];
}

- (void)p_showTableView:(NSInteger)index
{
    [_tableViews enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj[@"tableView"] setHidden:index!=idx];
    }];
    
    if ([self getTableView:index].mj_footer && [[self netdata:index] count] == 0)
    {
        [[self getTableView:index].mj_footer beginRefreshing];
    }
}
#pragma mark - 数据存取

- (void)setLoadNew:(BOOL)value forIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    [singleTableView setObject:@(value) forKey:@"loadNew"];
}

- (BOOL)getLoadNewForIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    return [singleTableView[@"loadNew"] boolValue];
}

// 获取网络数据
- (NSMutableArray*)netdata:(NSInteger)index
{
    if ([_tableViews count] > index)
    {
        NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
        return singleTableView[@"netData"];
    }
    else
        return nil;
}

// 插入网络数据
- (void)addNetData:(NSArray*)data index:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    NSMutableArray* netData = singleTableView[@"netData"];
    [netData addObjectsFromArray:data];
}

// 设置网络数据
- (void)setNetData:(NSArray*)data forIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    [singleTableView setObject:[data mutableCopy] forKey:@"netData"];
}

// 获取页面加载大小
- (NSInteger)pageSizeForIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    return [singleTableView[@"pageSize"] integerValue];
}

// 设置页面加载大小
- (void)setPageSize:(NSInteger)size forIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    singleTableView[@"pageSize"] = @(size);
}

// 获取页码
- (NSInteger)pageNoForIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    return [singleTableView[@"currentPage"] integerValue];
}

// 设置页码
- (void)setPageNo:(NSInteger)num forIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    [singleTableView setObject:@(num) forKey:@"currentPage"];
}

// 获取要操作的行号
- (NSInteger)index2oprateForIndex:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    return [singleTableView[@"index2oprate"] integerValue];
}

// 设置要操作的行号
- (void)setIndex2oprate:(NSInteger)no forIndex:(NSInteger)index;
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    [singleTableView setObject:@(no) forKey:@"index2oprate"];
}

- (UITableView*)getTableView:(NSInteger)index
{
    NSMutableDictionary* singleTableView = [_tableViews objectAtIndex:index];
    return singleTableView[@"tableView"];
}

- (UITableView*)getCurrentTableView
{
    UITableView* currenttableView = [self getTableView:[self p_getCurrentIndex]];
    return currenttableView;
}



#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* data = [self netdata:[tableView tag]];
    return data?[data count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义变量保存重用标记的值
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //    2.如果缓存池中没有符合条件的cell,就自己创建一个Cell
    if (cell == nil)
    {
        //    3.创建Cell, 并且设置一个唯一的标记
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [self p_configCell:cell row:indexPath.row forTableIndex:[tableView tag]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self p_didSelectRow:indexPath inTableView:[tableView tag]];
}

#pragma mark - to ovrrider

- (void)p_loadDataNew:(NSInteger)index{}

- (void)p_loadDataNext:(NSInteger)index{}

- (void)p_configCell:(UITableViewCell*)cell row:(NSInteger)row forTableIndex:(NSInteger)index{}

- (void)p_didSelectRow:(NSIndexPath *)indexPath inTableView:(NSInteger)index{}

// 数据是否变化
- (BOOL)p_isDataChange:(NSArray*)data index:(NSInteger)index
{
    return YES;
}

// 当前激活的表格
- (NSInteger)p_getCurrentIndex
{
    return 0;
}

// 合并数据 这里直接替换 子类可修改合并策略
- (void)p_mergeData:(NSArray*)data index:(NSInteger)index
{
    [self setNetData:data forIndex:index];
}

// 处理网络收到的数据
- (void)p_processData:(NSArray*)data forIndex:(NSInteger)index
{
    NSMutableArray* netData = [self netdata:index];
    
    if([self getLoadNewForIndex:index])
    {
        // 下拉刷新
        if (!netData || [netData count] == 0 || [data count] == 0)
        {
            [self setNetData:data forIndex:index];
            if ([data count] < [self pageSizeForIndex:index])
            {
                [self p_addEnd];
            }
            if ([self pageNoForIndex:index] == 0)
            {
                [self setPageNo:1 forIndex:index];
            }
            [[self getTableView:index] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
        
        if (data && [data count] > 0 && [self p_isDataChange:data index:index])
        {
            [self p_mergeData:data index:index];
            if ([data count] < [self pageSizeForIndex:index])
            {
                [self p_addEnd];
            }
            if ([self pageNoForIndex:index] == 0)
            {
                [self setPageNo:1 forIndex:index];
            }
            [[self getTableView:index] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else
    {
        // 翻页
        if (data && [data count] > 0)
        {
            [self setPageNo:[self pageNoForIndex:index]+1 forIndex:index];
            if ([data count] < [self pageSizeForIndex:index])
            {
                [self p_addEnd];
            }
            
            [self addNetData:data index:index];
            if ([self pageNoForIndex:index] == 1)
            {
                [[self getTableView:index] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [[self getTableView:index] reloadData];
                // 加载新内容向上滚动一段距离
                NSInteger newOffset = [[self getTableView:index] contentOffset].y + 60;
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     [[self getTableView:index] setContentOffset:CGPointMake(0, newOffset)];;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
            }
        }
        else
        {
            [self p_addEnd];
        }
    }
}


- (void)p_processDeleteForIndex:(NSInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self netdata:index] removeObjectAtIndex:[self index2oprateForIndex:index]];
        [[self getTableView:index] deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self index2oprateForIndex:index] inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        // 如果不重新加载会影响block里的row变量
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTable:) userInfo:@(index) repeats:NO];
    });
}

- (void)reloadTable:(NSTimer*)timer
{
    NSInteger index = [[timer userInfo] integerValue];
    [[self getTableView:index] reloadData];
}

- (void)p_addEnd
{
    // 没有更多数据了
    [[self getCurrentTableView].mj_footer endRefreshingWithNoMoreData];
}


// 结束刷新UI
- (void)p_stopReflash
{
    [_tableViews enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITableView* tableView = obj[@"tableView"];
        if (tableView.mj_header)
        {
            [tableView.mj_header endRefreshing];
        }
        
        if (tableView.mj_footer)
        {
            if (tableView.mj_footer.state != MJRefreshStateNoMoreData)
            {
                [tableView.mj_footer endRefreshing];
            }
        }
    }];
}
@end
