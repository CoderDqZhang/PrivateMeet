//
//  BaseUserInfoViewController.m
//  Meet
//
//  Created by Zhang on 6/6/16.
//  Copyright © 2016 Meet. All rights reserved.
//

#import "BaseUserInfoViewController.h"
#import "LabelAndTextFieldCell.h"
#import "UISheetView.h"
#import "UserInfoViewModel.h"
#import "WXUserInfo.h"
#import "Meet-Swift.h"
#import "UIImage+Alpha.h"
#import "NSString+StringType.h"

@interface BaseUserInfoViewController ()


@end

@implementation BaseUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNewUser"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"";
    self.isBaseView = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setUpView];
    [self setNavigationItemBar];
    self.talKingDataPageName = @"Login-BaseUser";
}

- (void)setNavigationItemBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep:)];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigationbar_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)],[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithHexString:HomeDetailViewNameColor]];
}

- (void)leftItemClick:(UIBarButtonItem *)sender
{
    
    [UIAlertController shwoAlertControl:self title:@"注意" message:@"资料未完善，确定退出编辑吗？" cancel:@"取消" doneTitle:@"确定" cancelAction:^{
        
    } doneAction:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
}

- (void)setUpView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_image1"]];
    imageView.frame = CGRectMake(-10, 170, 70, 110);
    [self.tableView addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self removeBottomLine];
}

- (void)nextStep:(UIBarButtonItem *)sender
{
    [self mappingUserInfoWithDicValues];
    
    if ([self chectBaseInfo]) {
        [self.viewModel updateUserInfo:[UserInfo sharedInstance] withStateArray:[self.stateArray copy] success:^(NSDictionary *object) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isNewUser"];
            [UIAlertController shwoAlertControl:self title:@"设置您的邀约" message:@"邀约设置后，有助于他人了解您的约见说明，从而更精准的吸引志趣相投的朋友。" cancel:@"逛逛再说" doneTitle:@"设置邀约" cancelAction:^{
//                if (_isDetailViewLogin) {
//                    if (_detailViweActionSheetSelect == 1) {
//                        ReportViewController *reportVC = [[ReportViewController alloc] init];
//                        reportVC.uid = _user_id;
//                        [self.navigationController pushViewController:reportVC animated:YES];
//                    }else{
//                        [self.navigationController popViewControllerAnimated:YES];
//                        if (self.blackListBlock != nil) {
//                            self.blackListBlock();
//                        }
//                    }
//                }else if (_isHomeListViewLogin){
//                    [self.navigationController popViewControllerAnimated:YES];
//                    if (self.homeListBlock != nil) {
//                        self.homeListBlock();
//                    }
//                }else if (_isApplyMeetViewLogin){
//                    [self.navigationController popViewControllerAnimated:YES];
//                    if (self.applyMeeBlock != nil) {
//                        self.applyMeeBlock();
//                    }
//                }else{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            } doneAction:^{
                SenderInviteViewController *senderInviteVC = Storyboard(@"Me", @"SenderInviteViewController");
//                if (_isDetailViewLogin) {
//                    senderInviteVC.isDetailViewLogin = YES;
//                    senderInviteVC.detailViewActionSheetSelect = self.detailViweActionSheetSelect;
//                }else if(_isHomeListViewLogin){
//                    senderInviteVC.isHomeListLogin = YES;
//                }else if (_isApplyMeetViewLogin){
//                    senderInviteVC.isApplyMeetLogin = YES;
//                }
                senderInviteVC.isNewLogin = YES;
                [self.navigationController pushViewController:senderInviteVC animated:YES];
            }];
        } fail:^(NSDictionary *object) {
            [[UITools shareInstance] showMessageToView:self.view message:@"保存失败" autoHide:YES];
        } loadingString:^(NSString *str) {
        }];
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  0.000001;
    }else{
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
