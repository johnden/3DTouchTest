//
//  ViewController.m
//  3DTouchTest
//
//  Created by DenJohn on 15/10/27.
//  Copyright © 2015年 gentlemen. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
   

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",@(indexPath.row)];
    
    
    //设置浮起的View
    if ([UIDevice currentDevice].systemVersion.floatValue>=9.0) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController* childVC= [[DetailViewController alloc] init];
    [self presentViewController:childVC animated:YES completion:nil];
    
}


//iOS 9.0以上才执行😂
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint)location{
    DetailViewController* childVC= [[DetailViewController alloc] init];
    childVC.preferredContentSize = CGSizeMake(00, 300);
    
    CGRect rect =CGRectMake(0,0, self.view.frame.size.width, 44);
    context.sourceRect=rect;
    return childVC;
    
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    //[self showViewController:viewControllerToCommit sender:self];
    
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
}

#endif



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
