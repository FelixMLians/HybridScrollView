//
//  FMLHybridScrollController.m
//  HybridScrollView
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import "FMLHybridScrollController.h"
#import "FMLItemTypeCell.h"
#import "FMLTopicTypeCell.h"

#import "Masonry.h"

#import "FMLHybridModel.h"

typedef NS_ENUM(NSUInteger, FMLHybridScrollViewCellType) {
    FMLHybridScrollViewCellTypeItem = 1,
    FMLHybridScrollViewCellTypeTopic,
    FMLHybridScrollViewCellTypeDefault,
};

static const CGFloat kCellTypeItemCellHeight = 220.0;
static const CGFloat kCellTypeTopicCellHeight = 150.0;
static const CGFloat kCellTypeDefaultCellHeight = 44.0;

static NSString *const kTableViewCellTypeItemIdentifier = @"FMLCellTypeItemIdentifier";
static NSString *const kTableViewCellTypeTopicIdentifier = @"FMLCellTypeTopicIdentifier";
static NSString *const kTableViewCellTypeDefaultIdentifier = @"FMLCellTypeDefaultIdentifier";

@interface FMLHybridScrollController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *itemTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *contentArray;
@property (nonatomic, copy) NSArray *bottomTitleArray;

@end

@implementation FMLHybridScrollController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMLHybridModel *model = self.dataSource[indexPath.row];
    if (1 == model.cellType) {
        FMLItemTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellTypeItemIdentifier];
        if (!cell) {
            cell = [[FMLItemTypeCell alloc] initWithEntity:model reuseIdentifier:kTableViewCellTypeItemIdentifier];
        }
        cell.tableViewIndexPath = indexPath;
//        cell.titleLabel.text = model.title;
//        cell.entity = model;
        return cell;
    }
    else if (2 == model.cellType) {
        FMLTopicTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellTypeTopicIdentifier];
        if (!cell) {
            cell = [[FMLTopicTypeCell alloc] initWithEntity:model reuseIdentifier:kTableViewCellTypeTopicIdentifier];
        }
        cell.tableViewIndexPath = indexPath;
//        cell.titleLabel.text = model.title;
//        cell.entity = model;
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellTypeDefaultIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:kTableViewCellTypeDefaultIdentifier];
        }
        cell.textLabel.text = model.title;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor blueColor];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMLHybridModel *model = self.dataSource[indexPath.row];
    if (1 == model.cellType) {
        return kCellTypeItemCellHeight;
    }
    else if (2 == model.cellType) {
        return kCellTypeTopicCellHeight;
    }
    else {
        return kCellTypeDefaultCellHeight;
    }
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Event Response

#pragma mark - Private Methods

- (void)configure {
    self.navigationItem.title = @"精品推荐";
    [self.view addSubview:self.itemTableView];
    
    [self.itemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // test data
    for (int i = 0; i < 8; i ++) {
        NSMutableArray *content = [[NSMutableArray alloc] init];
        for (int j = 0; j < 9; j ++) {
            FMLHybridModelContent *contentModel = [[FMLHybridModelContent alloc] init];
            contentModel.itemTitle = self.contentArray[j % 6];
            contentModel.typeString = @"游戏";
            contentModel.priceString = [NSString stringWithFormat:@"￥%.2f", (float)(arc4random() % 100 + 1)];
            [content addObject:contentModel];
        }
        FMLHybridModel *model = [[FMLHybridModel alloc] init];
        model.title = self.titleArray[i % 6];
        model.cellType = arc4random() % 2 + 1;
        model.itemsArray = content;
        [self.dataSource addObject:model];
    }
    for (int i = 0; i < 9; i ++) {
        FMLHybridModel *model = [[FMLHybridModel alloc] init];
        model.title = self.bottomTitleArray[i];
        model.cellType = 3;
        model.itemsArray = @[];
        [self.dataSource addObject:model];
    }
    
    [self.itemTableView reloadData];
}

#pragma mark - Accessor

- (UITableView *)itemTableView {
    if (!_itemTableView) {
        _itemTableView = [[UITableView alloc] init];
        _itemTableView.bounces = YES;
        _itemTableView.tableFooterView = [[UIView alloc] init];
        _itemTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _itemTableView.delegate = self;
        _itemTableView.dataSource = self;
    }
    return _itemTableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"本周新游", @"新鲜 App",@"精彩独立游戏限时 3元优惠",@"八月最佳 App",@"八月最佳游戏",@"热门 App",];
    }
    return _titleArray;
}

- (NSArray *)contentArray {
    if (!_contentArray) {
        _contentArray = @[@"每日故宫", @"PlayKids-学前节目",@"有道语文达人",@"方片记事",@"Spark Pro",@"Mimo: Learn how to code",];
    }
    return _contentArray;
}

- (NSArray *)bottomTitleArray {
    if (!_bottomTitleArray) {
        _bottomTitleArray = @[@"App 专题", @"游戏专题",@"轻松上手 App Store",@"编辑推荐",@"进一步了解App内购项目",@"iTUnes家长指南",@"充值",@"绑定银联卡支付",@"如何使用Apple Pay"];
    }
    return _bottomTitleArray;
}

@end
