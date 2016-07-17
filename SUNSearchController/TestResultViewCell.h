//
//  TestResultViewCell.h
//  SUNSearchController
//
//  Created by Michael on 16/7/17.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Product, TestResultViewCell;

@protocol TestResultViewCellDelegate <NSObject>

- (void)testResultViewCell:(TestResultViewCell *)testResultViewCell didLongPressRecognizer:(UILongPressGestureRecognizer *)longPressRecognizer;

@end

@interface TestResultViewCell : UITableViewCell

@property (nonatomic, strong) Product *product;
@property (nonatomic, weak) id<TestResultViewCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
