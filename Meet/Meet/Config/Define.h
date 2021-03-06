//
//  Define.h
//  Meet
//
//  Created by jiahui on 16/4/28.
//  Copyright © 2016年 Meet. All rights reserved.
//

#ifndef Define_h
#define Define_h


//#definition code @"BqT7gmS"


#define SHARE_APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度

#define SysVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS_7LAST ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)?1:0
#define IOS_8LAST ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)?1:0
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define NAVIGATION_BAR_COLOR   [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8]

#define WX_access_tokenURL_str          @"https://api.weixin.qq.com/sns/oauth2/access_token"
#define WX_refresh_tokenURL_str         @"https://api.weixin.qq.com/sns/oauth2/refresh_token"
#define WX_userInfo_URL_str             @"https://api.weixin.qq.com/sns/userinfo"

#define WXGET_access_tokenURL_str(code) [WX_access_tokenURL_str stringByAppendingFormat:@"?appid=%@&secret=%@&grant_type=authorization_code&code=%@",[AppData shareInstance].wxAppID,[AppData shareInstance].wxAppSecret,code]

#define WXRefresh_access_tokenURL_str(refresh_token)   [WX_refresh_tokenURL_str stringByAppendingFormat:@"?appid=%@&grant_type=refresh_token&refresh_token=%@",[AppData shareInstance].wxAppID,refresh_token]

#define GETUser_info_FromWX_URLStr [WX_userInfo_URL_str stringByAppendingFormat:@"?access_token=%@&openid=%@",[WXAccessModel shareInstance].access_token,[WXAccessModel shareInstance].openid]


#define Storyboard(StoryboarName,ViewControllerId)     [[UIStoryboard storyboardWithName:StoryboarName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:ViewControllerId]

#define UserDefaultsSynchronize(uname,key)  \
{ \
[[NSUserDefaults standardUserDefaults] setObject:uname forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize];\
}
#define UserDefaultsGetSynchronize(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define UserDefaultsRemoveSynchronize(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

#define MainTheand(Methon) \
{dispatch_async(dispatch_get_main_queue(), ^{  Methon  });}



#define WeiboApiKey       @"3220687526"
#define WeiboApiSecret    @"49d47e4aa35158eb8986cf60f5bc27d3"
#define WeiboRedirectUrl  @"http://sns.whalecloud.com/sina2/callback"


#define loginStateChange  @"loginStateChange"
#define UmengAppkey       @"5788abfd67e58e7e4f0005b9"

#define GAODEMapKey       @"a2001b013b8cd42ddb1982b3ba2f574a"

#define WeiXinPayStatues  @"WeixinPaySuccess"
#define AliPayStatues     @"AliPaySuccess"

#define TalkingDataAppId  @"7244A450FDAFB46FFEF7C1B68FBA93D3"

#define kDefaultChatroomId @"203138578711052716"


#endif /* Define_h */
