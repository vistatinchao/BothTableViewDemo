//
//  ZCViewController.m
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import "ZCViewController.h"
#import "ZCTagModel.h"
#import "ZCTagCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
@interface ZCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableview;
/**左侧标签数据源*/
@property (nonatomic,strong) NSArray *tags;

@end

@implementation ZCViewController

static NSString *const tagCellId = @"tag";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self requestTagData];
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推荐标签";
    [self.categoryTableview registerNib:[UINib nibWithNibName:NSStringFromClass([ZCTagCell class]) bundle:nil] forCellReuseIdentifier:tagCellId];
    self.categoryTableview.separatorColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.categoryTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

- (void)requestTagData {
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    paramsDict[@"a"] = @"category";
    paramsDict[@"c"] = @"subscribe";
    [SVProgressHUD show];
    [[AFHTTPSessionManager manager]GET:url parameters:paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.tags = [ZCTagModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableview reloadData];
        [self.categoryTableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        NSLog(@"%@",responseObject[@"list"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellId];
    cell.tagModel = self.tags[indexPath.row];
    return cell;
}




@end
