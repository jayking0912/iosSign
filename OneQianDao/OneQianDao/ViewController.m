//
//  ViewController.m
//  OneQianDao
//
//  Created by pi on 06/04/2018.
//  Copyright © 2018 jayking. All rights reserved.
//

#import "ViewController.h"
#import "CardLayOut.h"
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *MainNavItem;
@property (strong, nonatomic) IBOutlet UIView *Mainview;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableDictionary *usersDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //plist
//     NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cardDataPlist" ofType:@"plist"];
//    _usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
//    NSLog(@"%@", _usersDic);
//    NSLog(@"%lu", (unsigned long)[_usersDic count]);
//    NSMutableArray *numArray = [NSMutableArray arrayWithArray:_usersDic.allKeys];
//    NSLog(@"%@", [numArray objectAtIndex:1]);
//    NSMutableDictionary *a = [_usersDic objectForKey:[numArray objectAtIndex:1]];
//    NSLog(@"%@", [a objectForKey:@"name"]);
    
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
    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    cell.layer.cornerRadius = 5;
    
    int cellIndex = (int)indexPath.row;
    //读取对应位置的数据
    if(_usersDic == nil){
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cardDataPlist" ofType:@"plist"];
        _usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    }
    NSMutableArray *merchantArray = [NSMutableArray arrayWithArray:_usersDic.allKeys];
    NSMutableDictionary *indexMerchant = [_usersDic objectForKey:[merchantArray objectAtIndex:cellIndex]];
    
    //设置标题
    UILabel *titleName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    titleName.text = [indexMerchant objectForKey:@"name"];
    titleName.textColor = [UIColor grayColor];
    titleName.font = [UIFont systemFontOfSize:20.0];
    [cell addSubview:titleName];
    
    //内容
    NSMutableDictionary *contextDic = [indexMerchant objectForKey:@"context"];
    NSMutableArray *contextKey = [NSMutableArray arrayWithArray:contextDic.allKeys];
    for(int i=0;i<[contextDic count];i++){
        NSMutableDictionary *tagDic = [contextDic objectForKey:[contextKey objectAtIndex:i]];
        CGFloat tag_H = 80.0;
        UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(30, 40+(tag_H+10)*i, cell_W-60, tag_H)];
        tagView.backgroundColor = [UIColor whiteColor];
        tagView.layer.cornerRadius = 10;
        //tag 标题
        UILabel *tagtitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 20)];
        tagtitle.text = [tagDic objectForKey:@"headText"];
        tagtitle.textColor = [UIColor blackColor];
        tagtitle.font = [UIFont systemFontOfSize:15.0];
        [tagView addSubview:tagtitle];
        
        [cell addSubview:tagView];
    }
    
    
    return cell;
}

@end
