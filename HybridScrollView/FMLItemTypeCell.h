//
//  FMLItemTypeCell.h
//  HybridScrollView
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMLHybridModel.h"

@interface FMLItemTypeCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *tableViewIndexPath;
@property (strong, nonatomic) FMLHybridModel *entity;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *showAllButton;
@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithEntity:(FMLHybridModel *)entity reuseIdentifier:(NSString *)identifier;

@end
