//
//  PushViewController.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/13.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *back;

@end

@implementation ShareViewController
- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
