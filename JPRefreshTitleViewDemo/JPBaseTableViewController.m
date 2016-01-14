//
//  JPBaseTableViewControllerWW.m
//  JPAttributeTest
//
//  Created by zongIMac on 15/12/24.
//  Copyright © 2015年 zongIMac. All rights reserved.
//

#import "JPBaseTableViewController.h"
#import "JPRefreshTitleView.h"


@interface JPBaseTableViewController ()

@property (nonatomic, strong)JPRefreshTitleView * refrshView;

@end

@implementation JPBaseTableViewController

static NSString * identifier = @"JPTableViewCell";
- (instancetype)init{
    return [self initWithNibName:NSStringFromClass([JPBaseTableViewController class]) bundle:[NSBundle mainBundle]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self,
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor redColor];
    
    //  为防止循环引用造成内存泄露，请进行强弱self转换
    //  下面三种写法可以和strong(self) / strongSelf /__strong typeof(weakself) self = weakself 随意搭配
    
    Weak(self);
    //    WeakSelf;
    //    __weak typeof(self) weakself = self;
    
    
    /*
     “__strong typeof(weakself) self = weakself;”
     必须命名weakself才能随意搭配,其他命名不能随意搭配
     其他命名时需重新命名后面的weakself,self的命名也可以更改
     */
    
    self.refrshView = [JPRefreshTitleView showRefreshViewInViewController:self
                                                     observableScrollView:self.tableView
                                                                    title:@"JPRefreshTitleView"
                                                                     font:[UIFont systemFontOfSize:18]
                                                                textColor:[UIColor blackColor]
                                                          refreshingBlock:^{
                                                              
                                                              //StrongSelf;
                                                              //Strong(self);
                                                              __strong typeof(weakself) self = weakself; //self可改成其他命名
                                                              
                                                              [self.tableView reloadData];
                                                              [self endRefresh];
                                                          }];
    
    self.refrshView.activityIndicatorColor = [UIColor purpleColor];
    
    // 可以拓展成按钮或者其他视图，内部会重新调整大小适应JPRefreshTitleView的大小
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 20, 20, 20);
    view.backgroundColor = [UIColor purpleColor];
    self.refrshView.rightView = view;
}

- (void)endRefresh{
    [self.refrshView performSelector:@selector(stopRefresh) withObject:nil afterDelay:2];
}


#pragma mark - tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"refrshView.rightView可以拓展成按钮或者其他视图";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

//  分割线的偏移量
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}




#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }return _dataSourceArray;
}

- (void)dealloc{
    JKLog(@"%@实例对象被释放",[self class]);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
