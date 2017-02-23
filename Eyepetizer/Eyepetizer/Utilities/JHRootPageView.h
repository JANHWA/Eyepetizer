//
//  JHRootPageView.h
//  JHSlidePageViewController
//
//  Created by John on 16/7/5.
//  Copyright © 2016年 kuxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface JHRootPageView : UIView

/**
 *  按钮的父视图
 */
@property (nonatomic, strong) UIView *btnBgView;

/**
 *  滑动条
 */
@property (nonatomic, strong) UILabel *slideLabel;

/**
 *  初始化PageViewController
 *
 *  @param frame       视图位置大小
 *  @param VcArray     视图数组
 *  @param title       按钮标题
 *  @param bottomLine  是否有底部滑动条
 *  @param controller  所在的视图控制器
 *  @param height      按钮的高度
 *  @param normalColor 按钮默认的颜色
 *  @param selectcolor 按钮选中状态颜色
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
                  controllers:(NSArray *)VcArray
                        title:(NSArray *)title
                         type:(BOOL)bottomLine
                addController:(UIViewController *)controller
                    btnHeight:(CGFloat)height
               btnNormalColor:(UIColor *)normalColor
               btnSelectcolor:(UIColor *)selectcolor;


@end
