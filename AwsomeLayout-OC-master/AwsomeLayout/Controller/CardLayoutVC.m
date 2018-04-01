//
//  CardLayoutVC.m
//  AwsomeLayout
//
//  Created by Mr.Chen on 2017/3/12.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "CardLayoutVC.h"
#import "CardLayOut.h"

@interface CardLayoutVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation CardLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CardLayOut *layout = [CardLayOut new];
    layout.scale = 1.1;
//    layout.itemSize = CGSizeMake(200, 300);
    layout.itemSize = CGSizeMake(screen_W-40, 350);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    //背景底色
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
//    self.collectionView.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.8 alpha:1.0];
//    self.collectionView.tintColor = [UIColor blueColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    cell.backgroundColor = [UIColor redColor]; //每个cell颜色
    
    cell.layer.cornerRadius = 5;
    return cell;
}

@end
