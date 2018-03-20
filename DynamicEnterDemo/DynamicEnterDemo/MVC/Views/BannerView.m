//
//  BannerView.m
//  BannerDemo
//
//  Created by Da.W on 2018/1/30.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "BannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface BannerView()<UIScrollViewDelegate>{
    int totalPage;
    CGFloat _frameWidth;
    CGFloat _frameHeight;
}
@property (strong, nonatomic)NSTimer *timer;
@property (assign, nonatomic)int page;
@end

@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    _frameWidth=self.bounds.size.width;
    _frameHeight=self.bounds.size.height;
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.delegate=self;
    [self addSubview:self.scrollView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _frameHeight-40, _frameWidth, 40)];
    [self addSubview:self.pageControl];
//    self.pageControl.backgroundColor=[UIColor blackColor];
//    self.pageControl.alpha=0.4;
}

-(void)setImageViewArray:(NSMutableArray *)imageViewArray{
    totalPage=imageViewArray.count;
    //前后分别加上一张，以防出现空白情况
    _imageViewArray=[[NSMutableArray alloc]init];
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:[imageViewArray lastObject]];
    UIImageView *copyLastView = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
    NSData *archiveData2 = [NSKeyedArchiver archivedDataWithRootObject:[imageViewArray firstObject]];
    UIImageView *copyFirstView = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData2];
    [_imageViewArray addObject:copyLastView];
    [_imageViewArray addObjectsFromArray:imageViewArray];
    [_imageViewArray addObject:copyFirstView];
    
    for (int i=0;i<_imageViewArray.count; i++) {
        UIImageView *imageView = _imageViewArray[i];
        [imageView setFrame:CGRectMake(_frameWidth*i, 0, _frameWidth, _frameHeight)];
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setContentSize:CGSizeMake(_frameWidth*(totalPage+2), _frameHeight)];
    [self.scrollView setContentOffset:CGPointMake(_frameWidth*(1), 0) animated:NO];
    [self.pageControl setNumberOfPages:totalPage];
    [self.pageControl setCurrentPage:0];
    [self startMoving];
}

-(void)setImageUrlArray:(NSMutableArray *)imageUrlArray{
    totalPage=imageUrlArray.count;
    _imageUrlArray=[[NSMutableArray alloc]init];
    [_imageUrlArray addObject:[imageUrlArray lastObject]];
    [_imageUrlArray addObjectsFromArray:imageUrlArray];
    [_imageUrlArray addObject:[imageUrlArray firstObject]];
    
    for (int i=0; i<_imageUrlArray.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(_frameWidth*i, 0, _frameWidth, _frameHeight)];
        [imageView sd_setImageWithURL:_imageUrlArray[i] placeholderImage:[UIImage imageNamed:self.failedImage]];
        [self.scrollView addSubview:imageView];
    }
    
    [self.scrollView setContentSize:CGSizeMake(_frameWidth*(totalPage+2), _frameHeight)];
    [self.scrollView setContentOffset:CGPointMake(_frameWidth*(1), 0) animated:NO];
    [self.pageControl setNumberOfPages:totalPage];
    [self.pageControl setCurrentPage:0];
    [self startMoving];
}

-(void)setImageArray:(NSMutableArray *)imageArray{
    totalPage=imageArray.count;
    _imageArray=[[NSMutableArray alloc]init];
    [_imageArray addObject:[imageArray lastObject]];
    [_imageArray addObjectsFromArray:imageArray];
    [_imageArray addObject:[imageArray firstObject]];
    
    for (int i=0; i<_imageArray.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(_frameWidth*i, 0, _frameWidth, _frameHeight)];
        imageView.image=_imageArray[i];
        [self.scrollView addSubview:imageView];
    }
    
    [self.scrollView setContentSize:CGSizeMake(_frameWidth*(totalPage+2), _frameHeight)];
    [self.scrollView setContentOffset:CGPointMake(_frameWidth*(1), 0) animated:NO];
    [self.pageControl setNumberOfPages:totalPage];
    [self.pageControl setCurrentPage:0];
    [self startMoving];
}

#pragma mark - 时间
-(void)startMoving{
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextAd) userInfo:nil repeats:YES];
}

-(void)stopMoving{
    [_timer invalidate];
}

-(void)nextAd{
    if (_page >= totalPage-1) {
        //滚动到“最后一页”的位置，直接转到第（一-1）页
        [self.scrollView setContentOffset:CGPointMake(_frameWidth*(0), 0) animated:NO];
        _page=0;
    }else{
        _page++;
    }
    [self.scrollView setContentOffset:CGPointMake(_frameWidth*(_page+1), 0) animated:YES];
    self.pageControl.currentPage=_page;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x/_frameWidth==(totalPage+1)) {
        //滚动到（最后+1）一页，直接转到“第一页”
        [self.scrollView setContentOffset:CGPointMake(_frameWidth*(1), 0) animated:NO];
    }else if(self.scrollView.contentOffset.x==0){
        //滚动到（第一-1）页，直接转到最后一页
        [self.scrollView setContentOffset:CGPointMake(_frameWidth*(totalPage), 0) animated:NO];
    }
    _page=self.scrollView.contentOffset.x/_frameWidth-1;
    self.pageControl.currentPage=_page;
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self removeAdTimer];
//}
//
//
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    [self addAdTimer];
//}
@end
