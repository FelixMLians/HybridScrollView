//
//  FMLHybridModel.m
//  HybridScrollView
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import "FMLHybridModel.h"

@implementation FMLHybridModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemsArray" : FMLHybridModelContent.class};
}

@end

@implementation FMLHybridModelContent

@end