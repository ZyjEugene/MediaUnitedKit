//
//  HomeViewController.m
//  MediaUnitedKit
//
//  Created by LEA on 2017/9/21.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "HomeViewController.h"
#import "MediaCaptureController.h"
#import "RecorderViewController.h"
#import "AudioPlayViewController.h"
#import "GalleryViewController.h"
#import "EditorViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MUK"; //MUK = MediaUnitedKit

    //加载各功能入口
    //边距|间距
    CGFloat margin = 10.f;
    //整体高度
    CGFloat height = kHeight-64-50;
    //按钮宽高
    CGFloat itemWidth = (kWidth-3*margin)/2,itemHieght = 0;
    //记录坐标
    CGFloat itemX = 0,itemY = 20;
    //背景颜色
    UIColor *bgColor = nil;
    //标题
    NSString *title = nil;
    for (int i = 0; i < 4; i ++) {
        if (i == 0) {
            itemX = margin;
            itemY = 20;
            itemHieght = height*2/3;
            title = @"拍摄";
            bgColor = RGBColor(255.0, 115.0, 152.0, 1.0);
        } else if (i == 1){
            itemX = 2*margin+itemWidth;
            itemY = 20;
            itemHieght = height/3;
            title = @"图片编辑";
            bgColor = RGBColor(255.0, 183.0, 59.0, 1.0);
        } else if (i == 2){
            itemX = margin;
            itemY = 20+margin+height*2/3;
            itemHieght = height/3;
            title = @"图库";
            bgColor = RGBColor(105.0, 215.0, 233.0, 1.0);
        } else {
            itemX = 2*margin+itemWidth;
            itemY = 20+margin+height/3;
            itemHieght = height*2/3;
            title = @"音频采集播放";
            bgColor = RGBColor(129.0, 149.0, 253.0, 1.0);
        }
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(itemX, itemY, itemWidth, itemHieght)];
        itemView.tag = 100+i;
        itemView.backgroundColor = bgColor;
        itemView.layer.masksToBounds = YES;
        itemView.layer.cornerRadius = 4.f;
        [self.view addSubview:itemView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d",i]]];
        imageView.origin = CGPointMake(0, itemHieght-imageView.height-40);
        [itemView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, itemHieght-50, itemWidth-20, 50)];
        label.text = title;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        [itemView addSubview:label];
        
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [itemView addGestureRecognizer:click];
    }
}

#pragma mark - 进入各个功能
- (void)clickAction:(UITapGestureRecognizer *)sender
{
    UIView *clickView = sender.view;
    NSInteger index = clickView.tag-100;
    switch (index)
    {
        case 0: //拍摄
        {
            MediaCaptureController *controller = [[MediaCaptureController alloc] init];
            BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navController animated:YES completion:nil];
            break;
        }
        case 1: //图片编辑
        {
            EditorViewController *controller = [[EditorViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 2: //图库
        {
            GalleryViewController *controller = [[GalleryViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 3: //音频采集播放
        {
            RecorderViewController *controller = [[RecorderViewController alloc] init];
            [controller setMp3FileNameBlock:^(NSString *mp3FileName) {
                AudioPlayViewController *playVC = [[AudioPlayViewController alloc] init];
                playVC.mp3FileName = mp3FileName;
                [self.navigationController pushViewController:playVC animated:YES];
            }];
            BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
