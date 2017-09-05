//
//  ViewController.m
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ViewController.h"
#import "ILIPanCell.h"
#import "ILIPanCellButtonModel.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ILIPanCellDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,weak)UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableview];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellBeginDraging) name:KCellBeginDraging object:nil];
    
}


- (void)setupTableview
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [tableview registerClass:[ILIPanCell class] forCellReuseIdentifier:@"pan"];
    self.tableview = tableview;
    
}




#pragma mark -- tableview datasource --


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSMutableArray *array = [NSMutableArray array];
    ILIPanCellButtonModel *shareModel = [ILIPanCellButtonModel panCellWithType:ILIPanCellButtonTypeShare width:40 titleColor:[UIColor whiteColor] backColor:[UIColor blackColor]];
    ILIPanCellButtonModel *deleteModel = [ILIPanCellButtonModel panCellWithType:ILIPanCellButtonTypeDelete width:60 titleColor:[UIColor grayColor] backColor:[UIColor redColor]];
    [array addObject:shareModel];
    [array addObject:deleteModel];
    
    ILIPanCell *cell = [ILIPanCell panCellWithTableview:tableView indexPath:indexPath btns:array];
    cell.lb.text = [NSString stringWithFormat:@"    %ld _ %ld",indexPath.section,indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}




- (void)handleClickCell:(UITableViewCell *)cell
{
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    [self tableView:self.tableview didSelectRowAtIndexPath:indexpath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)cellBeginDraging
{
    [self findCellClose];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self findCellClose];
}




- (void)findCellClose
{
    NSArray *cells =  self.tableview.visibleCells;
    for (ILIPanCell *cell in cells) {
        if (cell.isOpening) {
            [cell performSelector:@selector(close)];
            break;
        }
    }
}



@end
