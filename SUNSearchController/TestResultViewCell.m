//
//  TestResultViewCell.m
//  SUNSearchController
//
//  Created by Michael on 16/7/17.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import "TestResultViewCell.h"
#import "Product.h"

@interface TestResultViewCell ()

@property (weak, nonatomic) IBOutlet UIView *textView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *textButton;

@end

@implementation TestResultViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRecognizer:)];
    [longPressGesture setDelegate:self];
    [self.textButton addGestureRecognizer:longPressGesture];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 1. 可重用标示符
    static NSString *ID = @"TestResultViewCell";
    // 2. tableView查询可重用Cell
    TestResultViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TestResultViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setProduct:(Product *)product
{
    _product = product;
    
    self.titleLabel.text = product.name;
}

// 长按
- (void)longPressRecognizer:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(testResultViewCell:didLongPressRecognizer:)]) {
            [self.delegate testResultViewCell:self didLongPressRecognizer:gestureRecognizer];
        }
    }
}

@end
