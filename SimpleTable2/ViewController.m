//
//  ViewController.m
//  SimpleTable2
//
//  Created by wanghuiyong on 22/01/2017.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *dwarves;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dwarves = @[@"Sleepy", @"Sneezy", @"Bashful", @"Happy", @"Doc", 
                     @"grumpy", @"Dopey",  @"Thorin",  @"Dorin", @"Nori", 
                     @"Ori",    @"Balin",  @"Dwalin",  @"Fili",  @"Killi", 
                     @"Oin",    @"Gloin",  @"Bifur",   @"Bofur", @"Bombur"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dwarves count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    // 绘制 cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    // 为 cell 添加图像
    UIImage *image = [UIImage imageNamed:@"star"];
    cell.imageView.image = image;
    UIImage *highlightedImage = [UIImage imageNamed:@"star2"];
    cell.imageView.highlightedImage = highlightedImage;
    // cell 的文本及字体
    cell.textLabel.text = self.dwarves[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    // 行高, 此处的设置会被委托方法覆盖
    tableView.rowHeight = 70;
    
    // 单元样式
    if (indexPath.row < 7) {
        cell.detailTextLabel.text = @"Mr. Disney";
    } else {
        cell.detailTextLabel.text = @"Mr. Tolkien";
    }
    return cell;
}

// 委托方法
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  indexPath.row % 4;	// 缩进
}

// 点击某行, 在高亮前执行此函数
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return nil;				// 不能选中第一行
    } else if (indexPath.row % 2 == 0) {
        return [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];	// 返回创建的 indexPath 对象(下一行)
    } else {
        return indexPath;		// 允许选择改行
    }
}

// 选中某行后调用
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *rowValue = self.dwarves[indexPath.row];
    NSString *title = [[NSString alloc] initWithFormat:@"Row Selected"];
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@", rowValue];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 2 ? 50 : 30;		// 第3行行高较高
}
@end
