//
//  MJRefreshViewController.m
//  west dean delicious
//
//  Created by westonnaki on 15/9/8.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "MJRefreshViewController.h"
#import "MJRefresh.h"
#import "MGSwipeTableCell.h"
#import "Masonry.h"

@interface MJRefreshViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL loadNew;
}
@end

static NSString* identifier = @"mjrefresh_cell";

@implementation MJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageSize = 20;
    _currentPage = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_netData release];
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)p_initMJRefreshUI
{
    // tableview
    _tableView = [[UITableView new] autorelease];
    [[self view] addSubview:_tableView];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(64);
        make.bottom.equalTo(self.view);
    }];
    _tableView.tableFooterView = [[UIView new] autorelease];

    __block typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf onHeaderReflash];
    }];
    MJRefreshAutoNormalFooter* footor = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf onFooterReflash];
    }];
    _tableView.mj_footer = footor;
    if (_hideEnd)
        [footor setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [_tableView.mj_footer setAutomaticallyHidden:NO];
    [[self tableView] registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:identifier];
    if (!_manualLoad) {
        [_tableView.mj_footer beginRefreshing];
    }
}

- (void)onHeaderReflash
{
    loadNew = YES;
    [self p_loadDataNew];
}

- (void)onFooterReflash
{
    loadNew = NO;
    [self p_loadDataNext];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _netData?[_netData count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义变量保存重用标记的值
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //    2.如果缓存池中没有符合条件的cell,就自己创建一个Cell
    if (cell == nil)
    {
        //    3.创建Cell, 并且设置一个唯一的标记
        cell = [[[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [self p_configCell:cell row:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self p_didSelectRow:indexPath];
}

#pragma mark -
- (void)p_loadDataNew{}

- (void)p_loadDataNext{}

- (void)p_configCell:(UITableViewCell*)cell row:(NSInteger)row{}

// 数据是否变化
- (BOOL)p_isDataChange:(NSArray*)data
{
    return YES;
}

// 合并数据 这里直接替换 子类可修改合并策略
- (void)p_mergeData:(NSArray*)data
{
    [_netData release];
    _netData = [data mutableCopy];
}

- (NSInteger)p_rowsInSection:(NSInteger)section{return 0;}

- (void)p_didSelectRow:(NSIndexPath *)indexPath {}

- (void)p_processDelete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_netData removeObjectAtIndex:_index2oprate];
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_index2oprate inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        // 如果不重新加载会影响block里的row变量
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTable) userInfo:nil repeats:NO];
    });
}

- (void)reloadTable
{
    [_tableView reloadData];
}

// 处理网络收到的数据
- (void)p_processData:(NSArray*)data
{    
    if (!_netData) {
        _netData = [[NSMutableArray array] retain];
    }
    
    if(loadNew)
    {
        // 下拉刷新
        if (!_netData || [_netData count] == 0 || [data count] == 0)
        {
            [_netData release];
            _netData = [data mutableCopy];
            if ([data count] < _pageSize)
            {
                [self p_addEnd];
            }
            if (_currentPage == 0) {
                _currentPage = 1;
            }
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
        
        if (data && [data count] > 0 && [self p_isDataChange:data])
        {
            [self p_mergeData:data];
            if ([data count] < _pageSize)
            {
                [self p_addEnd];
            }
            if (_currentPage == 0) {
                _currentPage = 1;
            }
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else
    {
        // 翻页
        if (data && [data count] > 0)
        {
            _currentPage++;
            [_netData addObjectsFromArray:data];
            if (_currentPage == 1)
            {
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [[self tableView] reloadData];
                // 加载新内容向上滚动一段距离
                NSInteger newOffset = [_tableView contentOffset].y + 60;
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     [_tableView setContentOffset:CGPointMake(0, newOffset)];;
                                 }
                                 completion:^(BOOL finished){
                 
                                 }];
            }
            
            if ([data count] < _pageSize)
            {
                [self p_addEnd];
            }
        }
        else
        {
            [self p_addEnd];
        }
    }
}

- (void)p_addEnd
{
    // 没有更多数据了
    [[self tableView].mj_footer endRefreshingWithNoMoreData];
    _noMoreData = YES;
}

// 结束刷新UI
- (void)p_stopReflash
{
    [[self tableView].mj_header endRefreshing];
    if ([self tableView].mj_footer) {
        [[self tableView].mj_footer endRefreshing];
    }
}
@end
