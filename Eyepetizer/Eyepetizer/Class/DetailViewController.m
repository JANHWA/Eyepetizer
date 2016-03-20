//
//  DetailViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "KRVideoPlayerController.h"
#import "PlayerViewController.h"

@interface DetailViewController ()



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.54 green:0.52 blue:0.5 alpha:1];
    [self configUI];
}

- (void)configUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 300)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_detailCoverForFeed]];
     [self.view addSubview:imageView];
    
    imageView.userInteractionEnabled = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreenWidth-60)*0.5, 120, 60, 60);
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
    // 创建底部背景图
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + 300, kScreenWidth, kScreenHeight - 64 - 300)];
    [bgImage sd_setImageWithURL:[NSURL URLWithString:_detailCoverBlurred]];
    [self.view addSubview:bgImage];
    
    // 创建标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth - 20, 30)];
    label.text = _detailTitle;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor colorWithRed:0.909 green:0.912 blue:0.921 alpha:1.000];
    [bgImage addSubview:label];
    
    // 创建下划线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 37, kScreenWidth*0.5, 2)];
    line.backgroundColor = [UIColor colorWithRed:0.703 green:0.693 blue:0.713 alpha:1.000];
    [bgImage addSubview:line];
    
    // 创建类型及时长
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 41, kScreenWidth, 30)];
    label2.text = [NSString stringWithFormat:@"#%@ / %@\"",_detailCategory,_detailDuration];
    label2.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.82 alpha:1];
    [bgImage addSubview:label2];
    
    // 创建描述label
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, kScreenWidth-15-15, 180)];
    label3.text = _detailDescription;
    label3.textColor = [UIColor colorWithRed:0.856 green:0.855 blue:0.874 alpha:1.000];
    label3.font = [UIFont systemFontOfSize:19];
    label3.lineBreakMode = NSLineBreakByCharWrapping;
//    label3.backgroundColor = [UIColor redColor];
    label3.numberOfLines = 0;
    [bgImage addSubview:label3];
    
}

- (void)btnClick:(UIButton *)sender
{
    PlayerViewController *player = [[PlayerViewController alloc] init];
    NSURL *url = [NSURL URLWithString:_detailPlayUrl];
    player.url = url;
    player.imageUrl = _detailCoverBlurred;
    [self presentViewController:player animated:YES completion:^{
        
    }];

}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
