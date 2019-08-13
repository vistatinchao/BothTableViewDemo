//
//  ZCViewController.m
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import "ZCViewController.h"
#import "ZCTagModel.h"
#import "ZCUserModel.h"
#import "ZCTagCell.h"
#import "ZCUserCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#define ZCColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ZCGlobleColor [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(235)/255.0 alpha:1.0]

@interface ZCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableview;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/**左侧标签数据源*/
@property (nonatomic,strong) NSArray *tags;

@end

@implementation ZCViewController

static NSString *const tagCellId = @"tag";
static NSString *const userCellId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self requestTagData];
}

- (void)setUI {
    self.view.backgroundColor = ZCGlobleColor;
    self.title = @"推荐标签";
    [self.categoryTableview registerNib:[UINib nibWithNibName:NSStringFromClass([ZCTagCell class]) bundle:nil] forCellReuseIdentifier:tagCellId];
    self.categoryTableview.separatorColor = ZCGlobleColor;
    self.categoryTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCUserCell class]) bundle:nil] forCellReuseIdentifier:userCellId];
    self.userTableView.separatorColor = ZCGlobleColor;
    self.userTableView.rowHeight = 100;
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
        [self tableView:self.categoryTableview didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSLog(@"%@",responseObject[@"list"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.categoryTableview) {
        return self.tags.count;
    }else{
        ZCTagModel *tag = self.tags[self.categoryTableview.indexPathForSelectedRow.row];
        return tag.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==self.categoryTableview) {
        ZCTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellId];
        cell.tagModel = self.tags[indexPath.row];
        return cell;
    }else{
        ZCUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellId];
        ZCTagModel *tag = self.tags[self.categoryTableview.indexPathForSelectedRow.row];
        cell.userModel = tag.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==self.categoryTableview) {
        ZCTagModel *tag = self.tags[indexPath.row];
        if (tag.users.count) { // 直接刷新 避免重复请求数据
            [self.userTableView reloadData];
        }else{
            NSString *url = @"http://api.budejie.com/api/api_open.php";
            NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
            paramsDict[@"a"] = @"list";
            paramsDict[@"c"] = @"subscribe";
            paramsDict[@"category_id"] = @(tag.id);
            [[AFHTTPSessionManager manager]GET:url parameters:paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSArray *userArr = [ZCUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                [tag.users addObjectsFromArray:userArr];
                [self.userTableView reloadData];
                NSLog(@"%@",responseObject[@"list"]);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
        
    }
}




@end
