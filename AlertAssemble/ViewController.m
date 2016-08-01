//
//  ViewController.m
//  AlertAssemble
//
//  Created by 四威 on 2016/7/28.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "ViewController.h"
#import "AlertController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *_tableView;
    
}

@property (nonatomic, strong) NSArray *arrayTitles;

@property (nonatomic, strong) NSArray *arrayCtrs;

@end

@implementation ViewController

- (NSArray *)arrayTitles {
    
    if (!_arrayTitles) {
        
        _arrayTitles = @[@"Alert"];
        
    }
    
    return _arrayTitles;
}

- (NSArray *)arrayCtrs {
    
    if (!_arrayCtrs) {
        
        _arrayCtrs = @[[[AlertController alloc] init]];
        
    }
    
    return _arrayCtrs;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.arrayTitles.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.textLabel.text = self.arrayTitles[indexPath.section];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = self.arrayCtrs[indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
