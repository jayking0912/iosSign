//
//  ViewController.m
//  OneQianDao
//
//  Created by pi on 06/04/2018.
//  Copyright © 2018 jayking. All rights reserved.
//

#import "ViewController.h"
#import "CardLayOut.h"
#import <objc/runtime.h>
#import "HexToUIcolor.h"
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *MainNavItem;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableDictionary *usersDic;
@property (strong, nonatomic) IBOutlet UIView *MainVc;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一钱到";
    
    CardLayOut *layout = [CardLayOut new];
    layout.scale = 1.1;
    layout.itemSize = CGSizeMake(cell_W, cell_H);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 10;
    //根据plist数量
    if(_usersDic == nil){
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cardDataPlist" ofType:@"plist"];
        _usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    }
    return [_usersDic count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    
    int cellIndex = (int)indexPath.row;
    NSMutableArray *merchantArray = [NSMutableArray arrayWithArray:_usersDic.allKeys];
    NSMutableDictionary *indexMerchant = [_usersDic objectForKey:[merchantArray objectAtIndex:cellIndex]];
    
    //卡片颜色
//    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
//    cell.backgroundColor = [UIColor whiteColor];
    UIColor *temColor = [HexToUIcolor colorWithHexString:[indexMerchant objectForKey:@"titleColor"]];
    cell.backgroundColor =[temColor colorWithAlphaComponent:0.05];
    cell.layer.cornerRadius = 5;
    
    
    //读取对应位置的数据
    if(_usersDic == nil){
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cardDataPlist" ofType:@"plist"];
        _usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    }
    
    //设置标题背景颜色
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell_W, 40)];
//    titleView.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:172.0/255.0 blue:228.0/255.0 alpha:1.0];
    titleView.backgroundColor = [HexToUIcolor colorWithHexString:[indexMerchant objectForKey:@"titleColor"]];
    titleView.layer.cornerRadius = 5;
    //设置标题图片 30*30
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    imgview.image = [UIImage imageNamed:[indexMerchant objectForKey:@"imageName"]];
    [titleView addSubview:imgview];
    //设置标题文字
    UILabel *titleName = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 20)];
    titleName.text = [indexMerchant objectForKey:@"name"];
    titleName.textColor = [UIColor whiteColor];
    titleName.font = [UIFont systemFontOfSize:20.0];
    [titleView addSubview:titleName];
    [cell addSubview:titleView];
    
    //内容
    NSMutableDictionary *contextDic = [indexMerchant objectForKey:@"context"];
    NSMutableArray *contextKey = [NSMutableArray arrayWithArray:contextDic.allKeys];
    for(int i=0;i<[contextDic count];i++){
        NSMutableDictionary *tagDic = [contextDic objectForKey:[contextKey objectAtIndex:i]];
        CGFloat tag_H = 80.0;
        CGFloat tag_W = cell_W-60;
        UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(30, 60+(tag_H+10)*i,tag_W , tag_H)];
//        tagView.backgroundColor = [UIColor whiteColor];
        tagView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:250.0/255.0 blue:244.0/255.0 alpha:1.0];
        
       
        tagView.layer.cornerRadius = 10;
        //虚线
        CGFloat DotLine_X = tag_W*3/4;
        UIImageView *DotLine = [[UIImageView alloc]initWithFrame:CGRectMake(DotLine_X, 0, 10, tag_H)];
        DotLine.image = [self drawLineOfDashByImageView:DotLine];
//        DotLine.backgroundColor = [UIColor blackColor];
        //tag 图片
        UIImageView *tagImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
        tagImg.image = [UIImage imageNamed:[tagDic objectForKey:@"headImageName"]];
        //tag 标题
        UILabel *tagtitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 60, 20)];
        tagtitle.text = [tagDic objectForKey:@"headText"];
        tagtitle.textColor = [UIColor blackColor];
        tagtitle.font = [UIFont systemFontOfSize:15.0];
        //tag 副标题
        UILabel *tagDescribe = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, DotLine_X-80, 20)];
        tagDescribe.text = [tagDic objectForKey:@"describText"];
        tagDescribe.textColor = [UIColor grayColor];
        tagDescribe.font = [UIFont systemFontOfSize:12.0];
        //跳转按钮
        UIButton *jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(DotLine_X, 0, tag_W-DotLine_X, tag_H)];
        [jumpBtn setTitle:@"抢" forState:UIControlStateNormal];
        [jumpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        jumpBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        jumpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        jumpBtn.contentVerticalAlignment =UIControlContentHorizontalAlignmentCenter;
        NSString *jumpUrl =[tagDic objectForKey:@"jumpUrl"];
        NSString *donwloadUrl = [indexMerchant objectForKey:@"donwloadUrl"];
         //传递url参数
        objc_setAssociatedObject(jumpBtn, "jumpAppUrl", jumpUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(jumpBtn, "donwloadUrl", donwloadUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
       
        [jumpBtn addTarget:self action:@selector(jumpApp:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [tagView addSubview:DotLine];
        [tagView addSubview:tagImg];
        [tagView addSubview:tagtitle];
        [tagView addSubview:tagDescribe];
        [tagView addSubview:jumpBtn];
        
        
        [cell addSubview:tagView];
    }
    //底部行
    UILabel *footlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, cell_H-20, cell_W-20, 20)];
    footlabel.text = [NSString stringWithFormat:@"---最终解释权归%@所有---",[indexMerchant objectForKey:@"name"]];
    footlabel.textColor= [UIColor grayColor];
    footlabel.font = [UIFont systemFontOfSize:10.0];
    footlabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:footlabel];
    
    return cell;
}

-(void)jumpApp:(UIButton *)sender{
    NSString *jumpAppUrl = objc_getAssociatedObject(sender, "jumpAppUrl");
    NSString *donwloadUrl = objc_getAssociatedObject(sender, "donwloadUrl");
    if(jumpAppUrl != nil){
        //跳转该app
        [self JumpToUrlScheme:jumpAppUrl downloadUrl:donwloadUrl];
    }
}

/*********
 跳转app
**********/
-(BOOL)JumpToUrlScheme:(NSString*)webUrlText downloadUrl:(NSString*)downloadUrl{
    
    
    if([self OpenAppURL:webUrlText] != true){
        //前往appstore下载
        NSLog(@"未安装");
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"未安装该APP" message:@"是否前往appstore下载？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self OpenAppURL:downloadUrl];
        }];
        UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        [alert addAction:CancelAction];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return false;
    }
    return true;
}

-(BOOL)OpenAppURL:(NSString*)webUrl{
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [webUrl stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    
    NSURL *url = [NSURL URLWithString:encodeUrl];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
        return true;
    }
    return false;
}


/**
 *  通过 Quartz 2D 在 UIImageView 绘制虚线
 *
 *  param imageView 传入要绘制成虚线的imageView
 *  return
 */

- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {5,5};
    
    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 0.0, imageView.frame.size.height);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
