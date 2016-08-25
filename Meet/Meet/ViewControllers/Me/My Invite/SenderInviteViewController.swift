//
//  SenderInviteViewController.swift
//  Meet
//
//  Created by Zhang on 7/5/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import UIKit
import MJExtension
import IQKeyboardManager
import FDFullscreenPopGesture

typealias BlackListClouse = () -> Void



class SenderInviteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    internal var isNewLogin:Bool = false
    var viewModel:UserInfoViewModel!
    var allItems = NSMutableArray()
    var plachString = ""
    var selectItems = NSMutableArray()
    var textView:UITextView!
    var cell:InviteItemsTableViewCell!
    
    var isDetailViewLogin:Bool = false
    var detailViewActionSheetSelect:NSInteger = 0
    var user_id:String! = ""
    
    var blackListClouse:BlackListClouse!
    
    var isHomeListLogin:Bool = false
    
    var isApplyMeetLogin:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNetData()
        self.title = "设置邀约"
        self.setUpTableView()
        self.setNavigationItemBack()
        self.setNavigationBar()
        IQKeyboardManager.sharedManager().enable = false
        self.setupForDismissKeyboard()
        self.talKingDataPageName = "Me-Invite"
    }

    func loadNetData(){
        viewModel = UserInfoViewModel()
        viewModel.getAllInviteAllItems({ (dic) in
            self.allItems = ((dic as NSDictionary).objectForKey("all_themes")?.copy())! as! NSMutableArray
            self.plachString = (dic as NSDictionary).objectForKey("default_document") as! String
            if UserInviteModel.isFake() {
                for _ in 0...self.allItems.count - 1 {
                    self.selectItems.addObject("false")

                }
            }else{
                self.selectItems = NSMutableArray(array:UserInviteModel.themArray(0) as NSArray)
            }
            self.tableView.reloadData()
            self.changeNavigationBarItemColor()
            }, fail: { (dic) in
                
            }) { (msg) in
                
        }
    }
    
    func checkNavigationItemEnable() -> Bool {
        if  cell != nil && cell.interestView != nil && cell.interestView.selectItems.count >= 1 {
            for idx in 0...cell.interestView.selectItems.count - 1 {
                let ret = cell.interestView.selectItems[idx]
                if ret as! String == "true" && textView.text.length != 0 {
                    return true
                }
            }
        }
        return false
    }
    
    func setNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(SenderInviteViewController.sendreInvite))
        self.changeNavigationBarItemColor()
    }
    
    func changeNavigationBarItemColor() {
        self.navigationItem.rightBarButtonItem?.tintColor = self.checkNavigationItemEnable() ? UIColor.init(hexString:NavigationBarTintColorCustome) : UIColor.init(hexString:NavigationBarTintDisColorCustom)
    }
    
    func sendreInvite(){
        let arrayItems = NSMutableArray()
        for idx in 0...cell.interestView.selectItems.count - 1 {
            let ret = cell.interestView.selectItems[idx]
            if ret as! String == "true" {
                arrayItems.addObject(allItems[idx])
            }
        }
        
        var ret:Bool = true
        if !isNewLogin {
            ret = UserInviteModel.shareInstance().results[0].is_active
        }
        viewModel.uploadInvite(textView.text, themeArray: arrayItems as [AnyObject], isActive: ret,success: { (dic) in
            if self.isDetailViewLogin {
                if self.detailViewActionSheetSelect == 1 {
                    let reportVC = ReportViewController()
                    reportVC.uid = self.user_id
                    reportVC.myClouse = { _ in
                        UITools.showMessageToView(self.view, message: "投诉成功", autoHide: true)
                    }
                    self.navigationController?.pushViewController(reportVC, animated: true)
                }else{
                    let viewControllers:NSArray = (self.navigationController?.viewControllers)!
                    self.navigationController?.popToViewController(viewControllers.objectAtIndex(1) as! UIViewController, animated: true)
                }
            }else if self.isHomeListLogin{
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else if self.isNewLogin {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else if self.isApplyMeetLogin {
                let viewControllers:NSArray = (self.navigationController?.viewControllers)!
                self.navigationController?.popToViewController(viewControllers.objectAtIndex(2) as! UIViewController, animated: true)
            }else{
                if !UserInviteModel.shareInstance().results[0].is_active {
                    UserInviteModel.shareInstance().results[0].is_active = true
                }
                self.navigationController?.popViewControllerAnimated(true)
            }
            }, fail: { (dic) in
                
        }) { (msg) in
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpTableView(){
        self.tableView.registerClass(InviteItemsTableViewCell.self, forCellReuseIdentifier: "InviteItemsTableViewCell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.backgroundColor = UIColor.init(hexString: TableViewBackGroundColor)
        self.tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(cell:InviteItemsTableViewCell){
        if allItems.count > 0 {
            cell.setData(allItems.copy() as! NSArray, selectItems: selectItems.copy() as! NSArray)
        }
    }
    
    func setUpAlertContol(){
        let aletControl = UIAlertController.init(title: "确定关闭邀约？", message: "邀约关闭后，您将不会出现在首页了哦。", preferredStyle: UIAlertControllerStyle.Alert)
        let cancleAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (canCel) in
            (UserInviteModel.shareInstance().results[0]).is_active = true
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 2)], withRowAnimation: UITableViewRowAnimation.Automatic)
        })
        let doneAction = UIAlertAction.init(title: "关闭", style: UIAlertActionStyle.Default, handler: { (canCel) in
            (UserInviteModel.shareInstance().results[0]).is_active = false
            self.sendreInvite()
        })
        aletControl.addAction(cancleAction)
        aletControl.addAction(doneAction)
        self.presentViewController(aletControl, animated: true) { 
            
        }
    }
}

extension SenderInviteViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if isNewLogin || UserInviteModel.shareInstance().results[0].is_fake {
            return 2
        }else{
            return 3
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 77
            }else{
                return tableView.fd_heightForCellWithIdentifier("InviteItemsTableViewCell", configuration: { (cell) in
                    self.setData(cell as! InviteItemsTableViewCell)
                })
            }
        }else if (indexPath.section == 1){
            if indexPath.row == 0 {
                return 60
            }else{
                return ScreenHeight - (tableView.fd_heightForCellWithIdentifier("InviteItemsTableViewCell", configuration: { (cell) in
                    self.setData(cell as! InviteItemsTableViewCell)
                })) - 77 - 77 - 66 - 10 - 64
            }
        }else{
            return 77
        }
    }
}

extension SenderInviteViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cellId = "InviteTitleTableViewCell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! InviteTitleTableViewCell
                cell.setData("设置邀约主题", isSwitch: false, isShowSwitch: false)
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else{
                let cellId = "InviteItemsTableViewCell"
                cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! InviteItemsTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.clourse = { selectItem in
                    self.changeNavigationBarItemColor()
                }
                self.setData(cell)
                return cell
            }
        }else if (indexPath.section == 1) {
            if indexPath.row == 0 {
                let cellId = "InviteDetailTitleTableViewCell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! InviteDetailTitleTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None

                return cell
            }else{
                let cellId = "TableViewCell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                textView = UITextView()
                
                textView.placeholder = self.plachString
                if isNewLogin || UserInviteModel.isFake() {
                    
                }else{
                    let result = UserInviteModel.shareInstance().results[0]
                    if result.introduction != "" {
                        textView.text = result.introduction
                    }
                }
                
                textView.tintColor = UIColor.blackColor()
                textView.delegate = self
                textView.placeholderColor = UIColor.init(hexString: MeViewProfileContentLabelColorLight)
                IQKeyboardManager.sharedManager().enable = true
                textView.font = LoginCodeLabelFont
                cell?.contentView.addSubview(textView)
                textView.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo((cell?.contentView.snp_top)!).offset(0)
                    make.left.equalTo((cell?.contentView.snp_left)!).offset(15)
                    make.right.equalTo((cell?.contentView.snp_right)!).offset(-15)
                    make.bottom.equalTo((cell?.contentView.snp_bottom)!).offset(-20)
                })
                cell!.selectionStyle = UITableViewCellSelectionStyle.None
                return cell!
            }
        }else{
            let cellId = "InviteTitleTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! InviteTitleTableViewCell
            cell.setData("邀约已开启", isSwitch: (UserInviteModel.shareInstance().results[0]).is_active,isShowSwitch:true )
            cell.myCourse = { _ in
                self.setUpAlertContol()
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }
}
extension SenderInviteViewController : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if !isNewLogin {
            if !UserInviteModel.shareInstance().results[0].is_active {
                UserInviteModel.shareInstance().results[0].is_active = true
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 2)], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
        self.changeNavigationBarItemColor()
    }
}
