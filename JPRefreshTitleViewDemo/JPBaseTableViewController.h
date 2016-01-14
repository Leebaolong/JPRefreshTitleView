//
//  JPBaseTableViewControllerWW.h
//  JPAttributeTest
//
//  Created by zongIMac on 15/12/24.
//  Copyright © 2015年 zongIMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPBaseTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;
@end
