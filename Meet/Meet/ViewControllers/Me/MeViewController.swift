//
//  MeViewController.swift
//  Demo
//
//  Created by Zhang on 6/12/16.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class MeViewController: UIViewController {

    var tableView:UITableView!
    var imagesArray = NSMutableArray()
    var headImage:UIImage!
    var statusBar:UIView!
    var frame:CGRect!
    
    var userInfoModel = UserInfoViewModel()
    var meInfoTableViewCell = "MeInfoTableViewCell"
    var mePhotoTableViewCell = "MePhotoTableViewCell"
    var photoDetailTableViewCell = "PhotoDetailTableViewCell"
    let newMeetInfoTableViewCell = "NewMeetInfoTableViewCell"
    
    var meetCellHeight:CGFloat = 159


    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInviteInfo()
        
        self.setUpTableView()
        self.loadExtenInfo()
        self.setNavigationBar()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        let status = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
        status.backgroundColor = UIColor.clearColor()


        if (UserInfo.sharedInstance().isFirstLogin && UserInfo.isLoggedIn()) {
            UserInfo.sharedInstance().isFirstLogin = false
            self.loadExtenInfo()
            self.loadInviteInfo()
            UserInfo.synchronize()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.createImageWithColor(UIColor.whiteColor()), forBarPosition: .Any, barMetrics: .Default)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(18.0)]
    }
    
    func setUpTableView(){
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.view.addSubview(tableView)
        let meInfoNib = UINib(nibName: "MeInfoTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.registerNib(meInfoNib, forCellReuseIdentifier: "MeInfoTableViewCell")
        let mePhotoNib = UINib(nibName: "MePhotoTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.registerNib(mePhotoNib, forCellReuseIdentifier: "MePhotoTableViewCell")
        let mePhotoDetailNib = UINib(nibName: "PhotoDetailTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.registerNib(mePhotoDetailNib, forCellReuseIdentifier: "PhotoDetailTableViewCell")
        self.tableView.registerClass(NewMeetInfoTableViewCell.self, forCellReuseIdentifier: newMeetInfoTableViewCell)

        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(self.view.snp_top).offset(-64)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        })
    }
    
    func loadExtenInfo(){
        userInfoModel.getMoreExtInfo("", success: { (dic) in
            UserExtenModel.synchronizeWithDic(dic)
            }, fail: { (dic) in
                
            }, loadingString: { (msg) in
              
        })
    }
    
    func loadInviteInfo(){
        userInfoModel.getInvite({ (dic) in
            UserInviteModel.synchronizeWithDic(dic)
            self.tableView.reloadData()
            }, fail: { (dic) in
                
            }) { (msg) in
                
        }
    }
    
    func setNavigationBar(){
        if UserInfo.isLoggedIn() {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.createImageWithColor(UIColor.clearColor()), forBarPosition: .Any, barMetrics: .Default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.setLeftBarItem()
        }else{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.createImageWithColor(UIColor.whiteColor()), forBarPosition: .Any, barMetrics: .Default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(18.0)]
            self.setNavigationItemAplah(1, imageName: ["me_dismissBlack"], type: 1)
            self.setNavigationItemAplah(1, imageName: ["me_settingsBlack"], type: 2)
            
        }
    }
    
    func setLeftBarItem(){
        self.setNavigationItemAplah(1, imageName: ["me_dismiss"], type: 1)
        
        if UserInfo.sharedInstance().job_label == ""{
            self.setNavigationItemAplah(1, imageName: ["me_settings"], type: 2)
        }else{
            self.setNavigationItemAplah(1, imageName: ["me_settings","me_edit"], type: 3)
        }
    }
    
    func setNavigationItemAplah(imageAplah:CGFloat, imageName:NSArray, type:NSInteger)  {
        if type == 1 {
            let image = UIImage(named: imageName[0] as! String)?.imageByApplyingAlpha(imageAplah)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MeViewController.cancelPress(_:)))
        }else if type == 2{
            let image = UIImage(named: imageName[0] as! String)?.imageByApplyingAlpha(imageAplah)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MeViewController.rightPress(_:)))
        }else{
            let image = UIImage(named: imageName[0] as! String)?.imageByApplyingAlpha(imageAplah)
            
            let settingItem = UIBarButtonItem(image: image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MeViewController.rightPress(_:)))
            
            let image1 = UIImage(named: imageName[1] as! String)?.imageByApplyingAlpha(imageAplah)
            let editItem = UIBarButtonItem(image:image1?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MeViewController.editPress(_:)))
            
            self.navigationItem.rightBarButtonItems = [settingItem,editItem]
        }
    }
    
    
    func cancelPress(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    func editPress(sender:UIBarButtonItem){
        self.pushProfileViewControllr()
    }
    
    func rightPress(sender:UIBarButtonItem){
        let meStoryBoard = UIStoryboard(name: "Seting", bundle: NSBundle.mainBundle())
        let settingVC = meStoryBoard.instantiateViewControllerWithIdentifier("SetingViewController") as!  SetingViewController
        settingVC.logoutBlock = {()
            self.setNavigationBar()
            self.tableView.reloadData()
        }
        self.navigationController!.pushViewController(settingVC, animated:true)
    }
    
    
    func downLoadUserWeChatImage(){
        NetWorkObject.downloadTask(UserInfo.sharedInstance().avatar, progress: { (Progress) in
            
            }, destination: { (url, response) -> NSURL! in
                var documentsDirectoryURL = NSURL()
                do{
                    documentsDirectoryURL = try NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false)
                }catch{
                    
                }
                return documentsDirectoryURL .URLByAppendingPathComponent(response.suggestedFilename!)
        }) {(response, url, error) in
                let image = UIImage(contentsOfFile: url.path!)
                UserInfo.saveCacheImage(image, withName: "cover_photo")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushViewController(tag:NSInteger){
        switch tag {
        case 1:
            self.pushProfileViewControllr()
            break
        case 2:
            self.pushProfileViewControllr()
            break
        case 3:
            self.presentAddStarViewController()
            break
        case 4:
            self.presentMoreProfileViewController()
            break
        default: break
            
        }
    }
    
    func pushProfileViewControllr() {
        let meStoryBoard = UIStoryboard(name: "Me", bundle: NSBundle.mainBundle())
        
        let myProfileVC = meStoryBoard.instantiateViewControllerWithIdentifier("MyProfileViewController") as!  MyProfileViewController
        myProfileVC.fromeMeView = true
        myProfileVC.reloadMeViewBlock = {(uodataInfo:Bool) in
            self.setLeftBarItem()
            self.tableView.reloadData()
        }
        self.navigationController!.pushViewController(myProfileVC, animated:true)
    }
    
    func presentAddStarViewController(){
        //////展示更多个人信息
        let meStoryBoard = UIStoryboard(name: "Me", bundle: NSBundle.mainBundle())
        
        let addStarVC = meStoryBoard.instantiateViewControllerWithIdentifier("AddStarViewController") as!  AddStarViewController
        let controller = BaseNavigaitonController(rootViewController: addStarVC)
        self.navigationController!.presentViewController(controller, animated: true, completion: {
            
        })

    }
    
    func presentMoreProfileViewController(){
        //////展示更多个人信息
        let meStoryBoard = UIStoryboard(name: "Me", bundle: NSBundle.mainBundle())
        
        let moreProfileView = meStoryBoard.instantiateViewControllerWithIdentifier("MoreProfileViewController") as!  MoreProfileViewController
        let controller = BaseNavigaitonController(rootViewController: moreProfileView)
        self.navigationController!.presentViewController(controller, animated: true, completion: {
            
        })
        
    }
    
    func inviteHeight() -> CGFloat {
        
        return meetHeight(self.descriptionString(), instrestArray: self.instrestArray())
    }
    
    func descriptionString() -> String {
        let description = UserInviteModel.descriptionString(0)
        return description
    }
    
    func instrestArray() -> NSArray {
        let array = NSMutableArray()
        array.addObjectsFromArray(UserInviteModel.themArray(0))
        return array.copy() as! NSArray
    }
    
    func configNewMeetCell(cell:NewMeetInfoTableViewCell, indxPath:NSIndexPath)
    {
        cell.fd_enforceFrameLayout = false;
        cell.configCell(self.descriptionString(), array: self.instrestArray() as [AnyObject])
    }
    
    func presentViewLoginViewController(){
        let meStoryBoard = UIStoryboard(name: "Login", bundle: NSBundle.mainBundle())
        let resgisterVc = meStoryBoard.instantiateViewControllerWithIdentifier("weChatResgisterNavigation")
        self.presentViewController(resgisterVc, animated: true, completion: {
            
        });
    }

}

extension MeViewController : UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath,animated:true)
        if (!UserInfo.isLoggedIn()) {
            self.presentViewLoginViewController()
            return ;
        }
        if (indexPath.row == 0) {
            self.pushProfileViewControllr()
        } else if (indexPath.row == 1) {
            self.presentMoreProfileViewController()
        } else  if (indexPath.row == 3 || indexPath.row == 2) {
            let meStoryBoard = UIStoryboard(name: "Me", bundle: NSBundle.mainBundle())
            let senderInviteVC = meStoryBoard.instantiateViewControllerWithIdentifier("SendInviteViewController") as!  SendInviteViewController
            senderInviteVC.block = { () in
                self.tableView.reloadData()
            }
            self.navigationController!.pushViewController(senderInviteVC, animated:true)
        }else if(indexPath.row == 4){
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! MeInfoTableViewCell
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1.0)
            if cell.infoDetailLabel.text == "" {
                hud.labelText = "您已通过所有认证了哦"
            }else{
                hud.labelText = "客服Meet君会尽快联系您认证的哦，还请耐心等待。"
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if UserInfo.isLoggedIn() {
            switch indexPath.row {
            case 0:
                return ScreenWidth*272/375
            case 1:
                return 100
            case 2:
                return 50
            case 3:
                return meetCellHeight
            default:
                return 50
            }
        }else{
            switch indexPath.row {
                case 0:
                    return ScreenWidth*272/375
                case 1:
                    return 100
                default:
                    return 50
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if UserInfo.isLoggedIn() {
            let y = scrollView.contentOffset.y
            let index = NSIndexPath.init(forRow: 0, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(index) as? MePhotoTableViewCell
            if(y <= 0){
                if y <= -64 && cell != nil{
                    let frame = CGRectMake(375 * (y + 64)/(272 * 2), y + 64, ScreenWidth - 375 * (y + 64)/272, ScreenWidth*272/375 - y - 64)
                    cell!.avatarImageView.frame = frame
                    cell?.placImageView.frame = frame
                }
                if y <= -230 {
                    self.dismissViewControllerAnimated(true, completion: { 
                    })
                }
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.createImageWithColor(UIColor.init(red: 242.0/255.0, green: 241.0/255.0, blue: 238.0/255.0, alpha: 0)), forBarPosition: .Any, barMetrics: .Default)
                self.setLeftBarItem()
            }else{
                self.setNavigationItemAplah(y/124, imageName: ["me_dismissBlack"], type: 1)
                if UserInfo.sharedInstance().job_label == "" {
                    self.setNavigationItemAplah(y/124, imageName: ["me_settingsBlack"], type: 2)
                }else{
                    self.setNavigationItemAplah(y/124, imageName: ["me_settingsBlack","me_editBlack"], type: 3)
                }
                if cell != nil {
                }
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.createImageWithColor(UIColor.init(red: 242.0/255.0, green: 241.0/255.0, blue: 238.0/255.0, alpha: y/124)), forBarPosition: .Any, barMetrics: .Default)
                
                if y > 50{
                    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
                }else{
                    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
                }
                
            }
        }
    }
}

extension MeViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserInfo.isLoggedIn() {
            return 6
        }else{
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if UserInfo.isLoggedIn() && UserExtenModel.shareInstance().completeness != nil {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(mePhotoTableViewCell, forIndexPath: indexPath) as! MePhotoTableViewCell
                cell.avatarImageView.backgroundColor = UIColor.init(hexString: "e7e7e7")
                if UserExtenModel.shareInstance().cover_photo != nil {
                    let cover_photo:Cover_photo = Cover_photo.mj_objectWithKeyValues(UserExtenModel.shareInstance().cover_photo)
                    if cover_photo.photo != nil {
                        cell.avatarImageView .sd_setImageWithURL(NSURL.init(string:cover_photo.photo ), placeholderImage: nil, completed: { (image, error, type, url) in
                            UserExtenModel.saveCacheImage(image, withName: "cover_photo.jpg")
                        })
                    }else{
                        cell.avatarImageView .sd_setImageWithURL(NSURL.init(string: UserInfo.sharedInstance().avatar), placeholderImage: nil, completed: { (image
                            , error, type, url) in
                            UserInfo.saveCacheImage(image, withName: "headImage.jpg")
                        })
                    }
                }
              
                cell.avatarImageView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin;
                cell.cofigLoginCell(UserInfo.sharedInstance().real_name, infoCom: UserInfo.sharedInstance().job_label,compass: UserExtenModel.shareInstance().completeness)
                frame = cell.avatarImageView.frame;
                cell.block = { (tag) in
                    self.pushViewController(tag)
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier(photoDetailTableViewCell, forIndexPath: indexPath) as! PhotoDetailTableViewCell
                    cell.configCell(UserExtenModel.allImageUrl())
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier(meInfoTableViewCell, forIndexPath: indexPath) as! MeInfoTableViewCell
                if UserInviteModel.isFake(){
                    cell.configCell("me_newmeet", infoString: "我的邀约", infoDetail: "未开启     ")
                }else{
                    cell.configCell("me_newmeet", infoString: "我的邀约", infoDetail: "")
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.setinfoButtonBackGroudColor(lineLabelBackgroundColor)
                cell.hidderLine()
                return cell
            }else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCellWithIdentifier(newMeetInfoTableViewCell, forIndexPath: indexPath) as! NewMeetInfoTableViewCell
                cell.configCell(self.descriptionString(), array: self.instrestArray() as [AnyObject])
                cell.block = { (height) in
                    self.meetCellHeight = height + 80
                    let index = NSIndexPath.init(forRow: 2, inSection: 0)
                    self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.isHaveShadowColor(false)
                return cell
            }else if (indexPath.row == 5) {
                let identifier = "LastCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
                if cell == nil{
                    cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
                }
                cell!.selectionStyle = UITableViewCellSelectionStyle.None
                return cell!
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier(meInfoTableViewCell, forIndexPath: indexPath) as! MeInfoTableViewCell
                cell.configCell((userInfoModel.imageArray() as NSArray) .objectAtIndex(indexPath.row - 3) as! String, infoString: (userInfoModel.titleArray() as NSArray).objectAtIndex(indexPath.row - 3) as! String, infoDetail: "")
                if indexPath.row == 4 {
                    var string = "尚未通过身份、职业、电话认证       "
                    let auto_info = UserExtenModel.shareInstance().auth_info
                    if auto_info != "" && auto_info != nil {
                        let autoArray = auto_info.componentsSeparatedByString(",")
                        if autoArray.count == 3 {
                            string = ""
                        }else{
                            let dic = (ProfileKeyAndValue.shareInstance().appDic as NSDictionary).objectForKey("auth_info") as! NSDictionary
                            for autoInfo in autoArray {
                                let autoName = dic.objectForKey(autoInfo) as! String
                                let stringArray = string.componentsSeparatedByString(autoName) as NSArray
                                let firstChar = (stringArray[1] as! NSString).substringToIndex(1)
                                if firstChar == "、" {
                                    string = string.stringByReplacingOccurrencesOfString("\(autoName)、" , withString: "")
                                }else{
                                    string = string.stringByReplacingOccurrencesOfString("\(autoName)" , withString: "")
                                }
                                
                            }
                        }
                        
                    }
                    cell.infoDetailLabel.text = string
                    cell.setinfoButtonBackGroudColor(lineLabelBackgroundColor)
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(mePhotoTableViewCell, forIndexPath: indexPath) as! MePhotoTableViewCell
                cell.configlogoutView()
                cell.logoutBtn.addTarget(self, action: (#selector(MeViewController.presentViewLoginViewController)), forControlEvents: UIControlEvents.TouchUpInside)
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier(photoDetailTableViewCell, forIndexPath: indexPath) as! PhotoDetailTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.configLogoutView()
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.accessoryType = UITableViewCellAccessoryType.None
                return cell
            }else if (indexPath.row == 4) {
                let identifier = "LastCell"
                var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
                if cell == nil{
                    cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
                }
                cell!.selectionStyle = UITableViewCellSelectionStyle.None
                return cell!
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier(meInfoTableViewCell, forIndexPath: indexPath) as! MeInfoTableViewCell
                if indexPath.row == 2 {
                    cell.hidderLine()
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.configCell((userInfoModel.imageArray() as NSArray) .objectAtIndex(indexPath.row - 2) as! String, infoString: (userInfoModel.titleArray() as NSArray).objectAtIndex(indexPath.row - 2) as! String, infoDetail: "")
                return cell
            }
        }
   }
}


