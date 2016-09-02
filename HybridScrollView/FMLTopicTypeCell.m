//
//  FMLTopicTypeCell.m
//  HybridScrollView
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import "FMLTopicTypeCell.h"
#import "FMLCollectionTypeTopicCell.h"

#import "Masonry.h"

static const CGFloat kLeftRightMargin = 15.0;

@interface FMLTopicTypeCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation FMLTopicTypeCell

- (instancetype)initWithEntity:(FMLHybridModel *)entity reuseIdentifier:(NSString *)identifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        _entity = entity;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:20.0];
        [self.contentView addSubview:_titleLabel];
        
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        horizontalCellLayout.minimumInteritemSpacing = 10;
        horizontalCellLayout.minimumLineSpacing = 10;
        horizontalCellLayout.itemSize = CGSizeMake(200, 80);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:horizontalCellLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:NSClassFromString(@"FMLCollectionTypeTopicCell")
            forCellWithReuseIdentifier:@"FMLCollectionTypeTopicCellId"];
        
        [self.contentView addSubview:_collectionView];
        
        // add constraint
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10.0);
            make.left.mas_equalTo(self.contentView.mas_left).offset(12.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(12.0);
            make.height.mas_equalTo(30);
        }];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10.0);
            //            make.right.mas_equalTo(self.contentView.mas_right).offset(-12.0);
            make.left.mas_equalTo(self.contentView.mas_left).offset(0);
            //            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(18.0);
            make.height.mas_equalTo(80);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        }];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        //        // frame style
        //        CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
        //        _titleLabel.frame = CGRectMake(12, 10, 200, 30);
        //        _collectionView.frame = CGRectMake(0, 10 + 30 + 10, kScreenWidth, 80);
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.entity.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMLCollectionTypeTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMLCollectionTypeTopicCellId"
                                                                                 forIndexPath:indexPath];
    return cell;
}

//- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize itemSize = CGSizeMake(200, 80);
//    return itemSize;
//}

- (void)setEntity:(FMLHybridModel *)entity {
    _entity = entity;
    
    [self.collectionView reloadData];
}

@end
