//
//  AlertController.m
//  AlertAssemble
//
//  Created by 四威 on 2016/7/29.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "AlertController.h"
#import "JKAlert.h"

@interface AlertController ()<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *_tableView;
    
}

@property (nonatomic, strong) NSArray *arrayTitles;

@end

@implementation AlertController

- (NSArray *)arrayTitles {
    
    if (!_arrayTitles) {
        
        _arrayTitles = @[@"Tick", @"Cross", @"Wait", @"Text"];
        
    }
    
    return _arrayTitles;
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
    
    switch (indexPath.section) {
        case 0:
            [JKAlert alertTick];
            break;
        case 1:
            [JKAlert alertCross];
            break;
        case 2:
            [JKAlert alertWaiting:YES];
            break;
    }
    
}

@end
