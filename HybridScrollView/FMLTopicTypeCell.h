//
//  FMLTopicTypeCell.h
//  HybridScrollView
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMLHybridModel.h"

@interface FMLTopicTypeCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *tableViewIndexPath;
@property (strong, nonatomic) FMLHybridModel *entity;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign, getter=isShowTitle) BOOL showTitle;
@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithEntity:(FMLHybridModel *)entity reuseIdentifier:(NSString *)identifier;

@end
