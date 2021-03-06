//
//  UserProtocolViewController.m
//  Meet
//
//  Created by jiahui on 16/5/17.
//  Copyright © 2016年 Meet. All rights reserved.
//

#import "UserProtocolViewController.h"

@interface UserProtocolViewController () <UIWebViewDelegate>{
    
    UIWebView *_webView;
}


@end

@implementation UserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"使用协议";
    
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _webView.backgroundColor = [UIColor colorWithHexString:TableViewBackGroundColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://momeet.cn/web/agreement/"]]];
    [self.view addSubview:_webView];
    self.talKingDataPageName = @"Me-Protocol";
    [self addLineNavigationBottom];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.block) {
        self.block();
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return  YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
        NSLog(@"error :%@",error.localizedDescription);

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
