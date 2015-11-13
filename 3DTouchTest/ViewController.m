//
//  ViewController.m
//  3DTouchTest
//
//  Created by DenJohn on 15/10/27.
//  Copyright © 2015年 gentlemen. All rights reserved.
//

#import "ViewController.h"

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
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=9.0) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

//#if __IPHONE_OS_VERSION_MAX_ALLOWED >=

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint)location{
    UIViewController* childVC= [[UIViewController alloc] init];
    childVC.preferredContentSize = CGSizeMake(00, 300);
    
    CGRect rect =CGRectMake(10, location.y-10, self.view.frame.size.width-20, 200);
    context.sourceRect=rect;
    return childVC;
    
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}

#endif

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
