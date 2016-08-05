//
//  AlertController.m
//  AlertAssemble
//
//  Created by 四威 on 2016/7/29.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "AlertController.h"
#import "JKAlert.h"
#import "NSObject+JKAlert.h"

@interface AlertController ()<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *_tableView;
    
}

@property (nonatomic, strong) NSArray *arrayTitles;
@property (nonatomic, strong) NSArray *arrayDetails;

@end

@implementation AlertController

- (NSArray *)arrayTitles {
    
    if (!_arrayTitles) {
        
        _arrayTitles = @[@"Tick", @"Cross", @"Wait", @"Text", @"Text"];
        
    }
    
    return _arrayTitles;
}

- (NSArray *)arrayDetails {
    
    if (!_arrayDetails) {
        
        _arrayDetails = @[@"one second", @"default duration", @"touch up", @"one line", @"many lines"];
        
    }
    
    return _arrayDetails;
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
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.textLabel.text = self.arrayTitles[indexPath.section];
    
    cell.detailTextLabel.text = self.arrayDetails[indexPath.section];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [JKAlert alertTickDuration:1];
            break;
        case 1:
            [JKAlert alertCross];
            break;
        case 2:
            [JKAlert alertWaiting:YES];
            break;
        case 3:
            [JKAlert alertText:@"hello developer!"];
            break;
        case 4:
            [JKAlert alertText:@"He replied, “I have dreamed. I have turned my mind loose to imagine what I wanted to do. Then I have gone to bed and thought about my dreams. In the night I dreamt about my dreams. And when I awoke in the morning, I saw the way to make my dreams real. While other people were saying, \'You can\'t do that, it is impossible,\' I was well on my way to achieving what I wanted.” As Woodrow Wilson, 28th President of the U.S., said: “We grow great by dreams. All big men are dreamers.”"];
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
@end
