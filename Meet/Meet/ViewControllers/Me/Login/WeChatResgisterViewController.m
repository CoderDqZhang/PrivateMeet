//
//  WeChatResgisterViewController.m
//  Meet
//
//  Created by jiahui on 16/5/6.
//  Copyright © 2016年 Meet. All rights reserved.
//

#import "WeChatResgisterViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WXAccessModel.h"
#import "WXUserInfo.h"
#import "LoginViewModel.h"
#import "WXLoginViewController.h"

//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>
#import "UserInfoDao.h"

@interface WeChatResgisterViewController ()<UIGestureRecognizerDelegate>
{
    __weak IBOutlet UITextField *checkField;
}

@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation WeChatResgisterViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[LoginViewModel alloc] init];
    checkField.text = @"Z3pavMk";
    // Do any additional setup after loading the view.
    if (IOS_7LAST) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
//    [UITools customNavigationLeftBarButtonForController:self action:@selector(backAction:)];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)checkCodeButtonAction:(id)sender {
    #warning check code and into WeChat Longin
    if ([self isEmpty]) {
        [EMAlertView showAlertWithTitle:@"验证码错误" message:@"请输入正确有效的验证码" completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
            
        } cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    }else{
        __weak typeof(self) weakSelf = self;
        [_viewModel checkCode:checkField.text Success:^(NSDictionary *object) {
//            [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
            [weakSelf performSegueWithIdentifier:@"pushToWXLogin" sender:self];
        } Fail:^(NSDictionary *object) {
//            [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
            [EMAlertView showAlertWithTitle:@"验证码错误" message:@"请输入正确有效的验证码" completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                
            } cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        } showLoding:^(NSString *str) {
//            [self performSelectorOnMainThread:@selector(showHudInView:hint:) withObject:weakSelf.view withObject:str waitUntilDone:YES];
//            [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
        }];
    }
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToWXLogin"]) {
        WXLoginViewController *wxLoginView = segue.destinationViewController; //获取目的试图控制器对象，跟原来一样，在.m文件中要引入头文件
        wxLoginView.code = checkField.text;
    }
}

- (IBAction)useWeChatLogin:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oldUerLoginState:) name:@"OldUserLoginWihtWechat" object:nil];
//    if (![WXAccessModel shareInstance].isLostAccess_token) {
//        [SHARE_APPDELEGATE wechatLoginByRequestForUserInfo];
//        return ;
//    }
//    if (![WXAccessModel shareInstance].isLostRefresh_token) {
//        [SHARE_APPDELEGATE weChatRefreshAccess_Token];
//        return ;
//    }
        [self sendAuthRequest];
}

#pragma mark - NSNotificationCenter
- (void)oldUerLoginState:(NSNotification *)notification {
    ////可按提示添加内容
//    return ;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OldUserLoginWihtWechat" object:nil];
     NSNumber *state = [notification object];
    if (state) {
        __weak typeof(self) weakSelf = self;
        [_viewModel oldUserLogin:[WXUserInfo shareInstance] Success:^(NSDictionary *object) {
            [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
            
            [_viewModel getUserInfo:[WXUserInfo shareInstance].openid success:^(NSDictionary *object) {
                [[UserInfo shareInstance] mappingValuesFormWXUserInfo:[WXUserInfo shareInstance]];
                [[UserInfoDao shareInstance] insertBean:[UserInfo shareInstance]];
                [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
                [[UserInfoDao shareInstance] selectUserInfoWithUserId:[UserInfo shareInstance].userId];
                [self mappingNetData:object];
                [[UserInfoDao shareInstance] insertBean:[UserInfo shareInstance]];
                [self dismissViewControllerAnimated:YES completion:^{
                    [AppData shareInstance].isLogin = YES;
                    
                }];
            } fail:^(NSDictionary *object) {
                [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
            } loadingString:^(NSString *str) {
                
            }];
            /////重新获取到 [UserInfo shareInstance]主要是为了得到idKye
            
        } Fail:^(NSDictionary *object) {
            [self performSelectorOnMainThread:@selector(hideHud) withObject:nil waitUntilDone:YES];
            [EMAlertView showAlertWithTitle:@"账号不存在" message:@"Meet暂未开放注册，请获得邀请码后再重新登录" completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                
            } cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        } showLoding:^(NSString *str) {
            [self performSelectorOnMainThread:@selector(showHudInView:hint:) withObject:weakSelf.view withObject:str waitUntilDone:YES];

        }];
//        NSString *unionid = [WXUserInfo shareInstance].unionid;
//        ////判断是不是真的是老用户，此微信号是否真的注册过！！
//        if (unionid) {/////是老用户，退出登陆页面 isLogin YES
//#warning  是老用户 从网获取用户信息 并保存本地 退出登陆页面
//            
//            
        
    } else {
        [[UITools shareInstance] showMessageToView:self.view message:@"请求出错" autoHide:YES];
    }
}

- (void)mappingNetData:(NSDictionary *)dic
{
//    [UserInfo shareInstance].headimgurl = [dic objectForKey:@"avatar"];
//    [UserInfo shareInstance].brithday = [dic objectForKey:@"birthday"];
//    [UserInfo shareInstance].constellation = [dic objectForKey:@"constellation"];
//    [UserInfo shareInstance].sex = [dic objectForKey:@"gender"];
//    [UserInfo shareInstance].eMail = [dic objectForKey:@"eMail"];
//    [UserInfo shareInstance].height = [dic objectForKey:@"height"];
//    [UserInfo shareInstance].workCity = [dic objectForKey:@"workCity"];
//    [UserInfo shareInstance].income = [dic objectForKey:@"income"];
//    [UserInfo shareInstance].city = [dic objectForKey:@"location"];
//    [UserInfo shareInstance].phoneNo = [dic objectForKey:@"mobile_num"];
//    [UserInfo shareInstance].name = [dic objectForKey:@"real_name"];
//    [UserInfo shareInstance].WX_No = [dic objectForKey:@"weixin_num"];
    UserInfo *useriNfo = [UserInfo shareInstance];
    NSLog(@"");
}

#pragma mark - sender to WeChat
-(void)sendAuthRequest {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = [AppData random_uuid];
    [AppData shareInstance].wxRandomState = req.state;
    //第三方向微信终端发送一个SendAuthReq消息结构
    if (![WXApi sendReq:req]) {
        [[UITools shareInstance] showMessageToView:self.view message:@"请安装WeChart" autoHide:YES];
        NSLog(@"未安装WeChart");
    };
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer.class isSubclassOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        //         NSLog(@"Home interactivePopGestureRecognizer");
        return YES;
    }
    return YES;
}

- (void)dealloc {
    
}

- (BOOL)isEmpty
{
    
    BOOL ret = NO;
    if (checkField.text.length == 0) {
    
        ret = YES;
    }
    return ret;
}

@end
