//
//  HeaderView.h
//  ExpandTableHeaderView
//
//  Created by bingyu on 16/5/24.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

/**
 *  初始化方法
 *
 *  @param frame     自身位置、大小
 *  @param tableView 父容器
 *
 *  @return 实例化后的HeaderView
 */
- (instancetype)initWithFrame:(CGRect)frame withTableView:(UITableView *)tableView;

@end
