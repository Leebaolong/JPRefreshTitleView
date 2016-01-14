#### JPRefreshTitleView
仿《之乎日报、QQ》基于导航栏titleView的刷新控件，支持显示文字、刷新、拓展按钮。基于KVO实现
![image](https://github.com/XiFengLang/JPRefreshTitleView/raw/master/JPRefreshTitleViewGIF.gif)
![image](https://github.com/XiFengLang/JPRefreshTitleView/raw/master/JPRefreshTitleViewGIFTwo.gif)

#####Usage
因为存在Block循环引用，在网上找了强弱转换的宏，被我改了改（ARC环境测试有效）
```Object-C
    WeakSelf; // Weak(self); // __weak typeof(self) weakself = self;
    self.refrshView = [JPRefreshTitleView showRefreshViewInViewController:self
                                                     observableScrollView:self.tableView
                                                                    title:@"JPRefreshTitleView"
                                                                     font:[UIFont systemFontOfSize:18]
                                                                textColor:[UIColor blackColor]
                                                          refreshingBlock:^{
                                                              
                           StrongSelf; // Strong(self); // __strong typeof(weakself) self = weakself;
                           [self.tableView reloadData];
                     }];
```

**start or stop**

```Object-C
    [self.refrshView startRefresh];
    [self.refrshView stopRefresh];
```

**change the color**
 
```Object-C
    self.refrshView.activityIndicatorColor = [UIColor purpleColor];
```

**支持拓展**

```Obejct-C
    // 可以拓展成按钮或者其他视图，内部会重新调整大小适应JPRefreshTitleView的大小
    UIButton * button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 20, 20, 20);
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(selector) forControlEvents:(UIControlEvents)];
    self.refrshView.rightView = button;
```
