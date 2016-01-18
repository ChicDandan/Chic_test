//
//  TestViewController.m
//  test
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 xike. All rights reserved.
//

#import "TestViewController.h"
#import "UIColor+Hex.h"

@interface TestViewController ()

@property (strong, nonatomic) IBOutlet UIView *aView;



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"00bcd4" alpha:0.6];
    
    self.aView.hidden = YES;
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(100, 200, 100, 60);
//    button.backgroundColor = [UIColor orangeColor];
//    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImageView * aImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 60, 60)];;
//    aImage.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:aImage];
    aImage.image = [self downloadHeadpicBy:@"http://www.chic-tech.cn/image/member/13091592399/ae37f466-3949-4496-8535-f9c8df0cf7eathumbnail.jpg"];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self test];
}


- (UIImage *)downloadHeadpicBy:(NSString *)fileUrl
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
    result = [UIImage imageWithData:data];
    return result;
}


- (void)test
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"验证原密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
    }];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
        
    }];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    __weak typeof(self) weakSelf = self;
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.delegate = weakSelf;
            textField.returnKeyType = UIReturnKeyDone;
        }];
    [self presentViewController:alert animated:YES completion:nil];

}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
