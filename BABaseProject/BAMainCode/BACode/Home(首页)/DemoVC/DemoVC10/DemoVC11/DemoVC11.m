//
//  DemoVC11.m
//  BABaseProject
//
//  Created by 博爱 on 16/6/1.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "DemoVC11.h"
#import "DemoVC11_model.h"
#import "DemoVC11_Cell.h"
#import "DemoVC11_AutoLayout.h"
#import "BANewsNetManager.h"

static NSString * const DemoVC11_cellID = @"DemoVC11_Cell";

@interface DemoVC11 ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    DemoVC11_AutoLayoutDelegate
>
@property (nonatomic, strong) UICollectionView     *collectionView;
@property (nonatomic, strong) NSMutableArray       *dataArray;
@property (nonatomic, strong) DemoVC11_AutoLayout  *layout;
@property (nonatomic, strong) BANewsNetManager     *netManager;

@end

@implementation DemoVC11

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setVCBgColor:BA_White_Color];
    
    [self setupLayout];
}

- (void)setupLayout
{
//    self.netManager = [[BANewsNetManager alloc] init];
    [self getData];
    
//    _layout = [DemoVC11_AutoLayout new];
//    /*! 列数 */
//    _layout.columCounts = 3;
//    /*! 列间距 */
//    _layout.columSpace = 5;
//    /*! 行间距 */
//    _layout.itemSpace = 5;
//    /*! 边距 */
//    _layout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    _layout.delegate = self;
//    
//    self.collectionView.hidden = NO;
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = BA_Yellow_Color;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self.view addSubview:_collectionView];
        /*! 滚动条隐藏 */
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[DemoVC11_Cell class] forCellWithReuseIdentifier:DemoVC11_cellID];
        
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

#pragma mark - ***** 获取网络数据
- (void)getData
{
    [self BA_showAlert:BA_Loading];
    [BANewsNetManager getDemoVC11DataCompletionHandle:^(id model, NSError *error) {
        
        [self BA_hideProgress];
        if (!error)
        {
            self.dataArray = [(NSArray *)model mutableCopy];
            BALog([NSString stringWithFormat:@" **** %@", self.dataArray]);
        }
        else
        {
            [self BA_showAlertWithTitle:@"解析错误！"];
        }
    }];
}












@end
