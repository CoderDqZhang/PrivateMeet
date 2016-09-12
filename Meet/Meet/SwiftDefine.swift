//
//  SwiftDefine.swift
//  Meet
//
//  Created by Zhang on 6/12/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import Foundation

let version = (UIDevice.currentDevice().systemVersion as NSString).floatValue

let ApplyControllerTextFont = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 14.0):UIFont.systemFontOfSize(14)
let LoginCodeLabelFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 14.0):UIFont.systemFontOfSize(14)

let LoginCodeSelectLabelFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 14.0):UIFont.systemFontOfSize(14)

let LoginOldUserBtnFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 12.0):UIFont.systemFontOfSize(12)
let LoginPhoneLabelFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 18.0):UIFont.systemFontOfSize(18)

let LoginUserPropoclFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 12.0):UIFont.systemFontOfSize(12)

let LoginPhoneTextFieldFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 20.0):UIFont.systemFontOfSize(20)

let MeetDetailInterFont      = version >= 9.0 ? UIFont.init(name: "PingFangTC-Light", size: 23.0):UIFont.systemFontOfSize(23)

let MeetDetailImmitdtFont = version >= 9.0 ? UIFont.init(name: "PingFangSC-Semibold", size: 15):UIFont.systemFontOfSize(15)

let EmptyDataTitleFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 14.0):UIFont.systemFontOfSize(14)

let OrderConfirmBtnFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 12.0):UIFont.systemFontOfSize(12)

let OrderAppointThemeTypeFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 11.0):UIFont.systemFontOfSize(11)

let OrderAppointThemeIntroudFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 13.0):UIFont.systemFontOfSize(13)

let SpashViewFont =  version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 10.0):UIFont.systemFontOfSize(10)

let AppointMeetLogoPower      =     version >= 9.0 ? UIFont.init(name: "HelveticaNeue-LightItalic", size: 8.0):UIFont.systemFontOfSize(8)

let AppointRealNameLabelFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 11.0):UIFont.systemFontOfSize(11)

let AppointPositionLabelFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Thin", size: 11.0):UIFont.systemFontOfSize(11)

let AppointNameLabelFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 11.0):UIFont.systemFontOfSize(11)

let OrderApplyTitleFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 14.0):UIFont.systemFontOfSize(14)

let OrderPayViewTitleFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 14.0):UIFont.systemFontOfSize(14)

let OrderPayViewPayTitleFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Regular", size: 14.0):UIFont.systemFontOfSize(14)

let OrderPayViewPayDetailFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 9.0):UIFont.systemFontOfSize(9.0)

let OrderPayViewPayInfoFont    = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 11.0):UIFont.systemFontOfSize(11)

let OrderPayViewPayAllNumFont  = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 12.0):UIFont.systemFontOfSize(12)

let OrderPayViewPayMuchFont  = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 24.0):UIFont.systemFontOfSize(24)

let OrderInfoPayDetailFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 13.0):UIFont.systemFontOfSize(13.0)

let OrderInfoViewMuchFont      = version >= 9.0 ? UIFont.init(name: "Helvetica-Bold", size: 13.0):UIFont.systemFontOfSize(13.0)

let OrderCancelInfoViewFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Thin", size: 24.0):UIFont.systemFontOfSize(24.0)

let OrderMeetTipFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 12.0):UIFont.systemFontOfSize(12.0)

let OrderMeetTipTitleFont      = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 17.0):UIFont.systemFontOfSize(17.0)

let NavigationBarRightItemFont  = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size:16.0):UIFont.systemFontOfSize(16)

let HomeDetailCenterLabelFont  = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 13.0):UIFont.systemFontOfSize(13)

let AboutUsTitleFont  = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 19.0):UIFont.systemFontOfSize(19)
let AboutUsInfoFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Thin", size: 14.0):UIFont.systemFontOfSize(14)

let HightLightTitleFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 24.0):UIFont.systemFontOfSize(24)
let HightLightInfoFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Light", size: 16):UIFont.systemFontOfSize(16)


let LoginViewLabelFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 30):UIFont.systemFontOfSize(30)

let LoginInfoLabelFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 11):UIFont.systemFontOfSize(11)

let LoginButtonTitleFont   = version >= 9.0 ? UIFont.init(name: "PingFangSC-Medium", size: 9):UIFont.systemFontOfSize(9)

let ReloadOrderCollectionView = "ReloadOrderCollectionView"

func Stroyboard(storyName:String, viewControllerId:String) -> UIViewController {
    let storyboard = UIStoryboard.init(name: storyName, bundle: NSBundle.mainBundle())
    let viewController = storyboard.instantiateViewControllerWithIdentifier(viewControllerId)
    return viewController
}

func MainThreadAlertShow(msg:String,view:UIView){
    dispatch_async(dispatch_get_main_queue()) {
        UITools.shareInstance().showMessageToView(view, message: msg, autoHide: true)
    }
}

func UserDefaultsGetSynchronize(key:String) -> String {
    if NSUserDefaults.standardUserDefaults().objectForKey(key) != nil{
        return NSUserDefaults.standardUserDefaults().objectForKey(key)! as! String
    }else{
        return ""
    }
    
}

func TableViewRegisterNib(cell:String, idef:String, tableView:UITableView){
    tableView.registerNib(UINib.init(nibName: cell, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: idef)
}


let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height

let IPHONE_5_Height = ScreenHeight > 570.0 ? true : false


let KeyWindown = UIApplication.sharedApplication().keyWindow

let AvatarImageSize = ScreenWidth > 375.0 ? "?imageView2/1/w/168/h/168":"?imageView2/1/w/112/h/112"

let NavigaitonAvatarImageSize = ScreenWidth > 375.0 ? "?imageView2/1/w/102/h/102":"?imageView2/1/w/68/h/68"

let HomeCovertImageSize = ScreenWidth > 375.0 ? "?imageView2/1/w/1065/h/600":"?imageView2/1/w/710/h/400"

let HomeDetailCovertImageSize = ScreenWidth > 375.0 ? "?imageView2/1/w/1065/h/708":"?imageView2/1/w/710/h/472"

let HomeDetailMoreInfoImageSize = ScreenWidth > 375.0 ? "?imageView2/1/w/177/h/177":"?imageView2/1/w/118/h/118"

