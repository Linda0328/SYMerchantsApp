//
//  SYGuiderViewController.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/30.
//
//

#import "SYGuiderViewController.h"

@interface SYGuiderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *guiderCollection;
@property (nonatomic,strong)UIPageControl *pageC;
@end
static NSString *identifier = @"guider";
@implementation SYGuiderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *horizonLayout = [[UICollectionViewFlowLayout alloc]init];
    horizonLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _guiderCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:horizonLayout];
    _guiderCollection.delegate = self;
    _guiderCollection.dataSource = self;
    _guiderCollection.pagingEnabled = YES;
    _guiderCollection.showsHorizontalScrollIndicator = NO;
    _guiderCollection.bounces = NO;
    [self.view addSubview:_guiderCollection];
    
    [_guiderCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    _pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(3*self.view.bounds.size.width/8, self.view.bounds.size.height-65, self.view.bounds.size.width/4, 45)];
    _pageC.numberOfPages = _imageArr.count;
    [_guiderCollection addSubview:_pageC];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:cell.bounds];
    [imageV setImage:[UIImage imageNamed:_imageArr[indexPath.row]]];
    [cell.contentView addSubview:imageV];
    
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_guiderCollection]) {
        NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
        self.pageC.currentPage = page;
        if (scrollView.contentOffset.x>_imageArr.count*scrollView.frame.size.width) {
            if (self.dismissBlock) {
                self.dismissBlock();
            }
        }
    }
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
