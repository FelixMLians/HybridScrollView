//
//  FMLCollectionTypeItemCell.m
//  HybridScrollView
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import "FMLCollectionTypeItemCell.h"

#import "Masonry.h"

@implementation FMLCollectionTypeItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.backgroundColor = [self randomColor];
        _mainImageView.layer.cornerRadius = 10.0;
        _mainImageView.clipsToBounds = YES;
        [self.contentView addSubview:_mainImageView];
        
        _desLabel = [[UILabel alloc] init];
        _desLabel.textColor = [UIColor blackColor];
        _desLabel.font = [UIFont systemFontOfSize:13.0];
        _desLabel.numberOfLines = 0;
        [self.contentView addSubview:_desLabel];
        
        // add constraint
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(0.0);
            make.left.mas_equalTo(self.contentView.mas_left).offset(0.0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_mainImageView.mas_bottom).offset(0.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(0.0);
            make.left.mas_equalTo(self.contentView.mas_left).offset(0.0);
            make.width.mas_equalTo(_mainImageView.mas_width);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0.0);
        }];
        
        //        // frame style
        //        _mainImageView.frame = CGRectMake(0, 0, 80, 80);
        //        _desLabel.frame = CGRectMake(0, 80, 80, 72);
        
    }
    return self;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
