//
//  Product.h
//  SUNSearchController
//
//  Created by Michael on 16/6/14.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ProductTypeDevice;
extern NSString *const ProductTypeDesktop;
extern NSString *const ProductTypePortable;

@interface Product : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

+ (NSArray *)allProducts;

+ (instancetype)productWithType:(NSString *)type name:(NSString *)name;

+ (NSArray *)deviceTypeNames;
+ (NSString *)displayNameForType:(NSString *)type;

@end
