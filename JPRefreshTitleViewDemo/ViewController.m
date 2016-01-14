//
//  ViewController.m
//  JPRefreshTitleViewDemo
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 XiFengLang. All rights reserved.
//

#import "ViewController.h"
#import "JPRefreshTitleView.h"
#import "JPTableViewCell.h"
#import "JPBaseTableViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)JPRefreshTitleView * refrshView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 61;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
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
}

- (void)endRefresh{
//    [self.refrshView stopRefresh];
    [self.refrshView performSelector:@selector(stopRefresh) withObject:nil afterDelay:2];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JPTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JPTableViewCell class])];
    cell.label.text = @"跳转到JPBaseTableViewController";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JPBaseTableViewController * vc = [[JPBaseTableViewController alloc]init];
    for (NSInteger index = 0; index < 13; index++) {
        [vc.dataSourceArray addObject:@"JPRefreshTextView"];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
