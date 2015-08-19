//
//  MRRecommendTagsController.m
//  JustJoke
//
//  Created by Asuna on 15/8/16.
//  Copyright (c) 2015年 MR. All rights reserved.
//

#import "MRRecommendTagsController.h"
#import "MRRecommend.h"
#import "MRRecommendCell.h"

@interface MRRecommendTagsController ()

@property (nonatomic,strong) NSArray *arrayModel;
@property (nonatomic,strong) MRHttpTool *recommandHttpTool;

@end

@implementation MRRecommendTagsController

- (MRHttpTool *)recommandHttpTool
{
    if (_recommandHttpTool == nil) {
        _recommandHttpTool = [MRHttpTool shareHttpTool];
    }
    return _recommandHttpTool;
}

- (NSArray *)arrayModel
{
    if (_arrayModel == nil) {
        self.arrayModel = [NSArray array];
    }
    
    return _arrayModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBaseSetting];
    [self setUpSendHttp];
 

}

-(void)setUpBaseSetting
{
    self.title = @"推荐标签";
    self.tableView.rowHeight = 70;
    [self.tableView setBackgroundColor:MRGlobalBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MRRecommendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"recommand"];
}

-(void)setUpSendHttp
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    // 发送请求
    WEAKSELF
    [self.recommandHttpTool getWithURLString:@"api/api_open.php" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        weakSelf.arrayModel = [MRRecommend objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
    

}

- (void)dealloc
{
    [self.recommandHttpTool.tasks makeObjectsPerformSelector:@selector(cancel)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSInteger count =  self.arrayModel.count;
    return count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommand" forIndexPath:indexPath];
    
    MRRecommend *recommand = self.arrayModel[indexPath.row];
    cell.recommand = recommand;
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
