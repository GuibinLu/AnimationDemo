//
//  ViewController.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/3.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "ViewController.h"
#import "StyleKitName.h"
#import "WaterView.h"

//vc
#import "Transform3DViewController.h"


@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTableViewRow];
    //[self initPaintImage];
}

- (void)initPaintImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 250, 250);
    [button setBackgroundImage:[StyleKitName imageOfCanvas1] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}

- (void)setTableViewRow
{
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:
                       @"Transform3D",
                       @"Mask",
                       @"shapAndGradient",
                       @"POP",
                       @"Easing",
                       @"Replicator",
                       @"Emitter",
                       @"PresentLayer",
                       @"Transition",
                       @"DrawRect",
                       @"Crumbling",
                       @"TextAnimation",
                       @"CoolLabel",
                       nil];
    }
    return _dataSource;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID1"];
        WaterView * waterView = [[WaterView alloc]initWithFrame:CGRectMake(DeviceSize.width - 50, 5, 30, 30)];
        waterView.percentum = 0.5;
        waterView.alpha = 0.5;
        [cell.contentView  addSubview:waterView];
    }
    cell.textLabel.text  = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:self.dataSource[indexPath.row] sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
