//
//  MyProfileViewController.h
//  Meet
//
//  Created by jiahui on 16/4/30.
//  Copyright © 2016年 Meet. All rights reserved.
//


#define  FRIST_LOGIN_NOTIFICATION_Key  @"modifiUserInfoNotification"

typedef void(^needReloadProfileCellBlock)(BOOL updateImaeg,BOOL updateInfo);
typedef void(^needReloadMeViewBlock)(BOOL updateInfo);

#import <UIKit/UIKit.h>
#import "UserInfoViewModel.h"
#import "MeetBaseViewController.h"
#import "EMAlertView.h"

@interface MyProfileViewController : MeetBaseViewController<UITableViewDelegate,UITableViewDataSource>
{

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, weak) IBOutlet UIView *chooseView;

@property (strong, nonatomic) needReloadProfileCellBlock block;

@property (strong, nonatomic) needReloadMeViewBlock reloadMeViewBlock;

@property (assign, nonatomic)     NSInteger selectRow;////仅限Section0里

@property (assign, nonatomic)    NSInteger pickerSelectRow;

@property (strong, nonatomic) UserInfoViewModel *viewModel;

@property (copy, nonatomic) NSString *headImageUrl;

@property (copy, nonatomic) NSMutableDictionary *dicValues;////////tableView内容数据缓存 Key为对应的Title Value为用户填入的结果
@property (copy, nonatomic) NSArray *titleContentArray;

@property (copy, nonatomic) NSMutableDictionary *stateArray;

@property (assign, nonatomic) BOOL fromeMeView;

- (void)mappingUserInfoWithDicValues;

@end
