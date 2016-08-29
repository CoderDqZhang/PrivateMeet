//
//  ApplyMeetViewController.swift
//  Meet
//
//  Created by Zhang on 7/18/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import UIKit

class ApplyMeetViewController: UIViewController {

    
    var titleView:UIView!
    var lineLabel:UILabel!
    
    var tableView:UITableView!
    var viewModel:OrderViewModel!
    var flowPath:UIView!
    var host:String = ""
    var allItems = NSMutableArray()
    var plachString = ""
    var selectItems = NSMutableArray()
    
    var avater:String!
    var jobLabel:String!
    var realName:String!
    
    var leftButton:UIButton!
    var bottomBtn:UIButton!

    var cell:OrderApplyMeetTableViewCell!
    var introductionCell:OrderApplyIntroductionCell!
    
    var navigationBarTitleView: UIView!
    
    var keyboardHeight:CGFloat = 216
    
    var contenOfY:CGFloat = 0
    
    var loginView:LoginView!
        
    var isApplyOrder:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupForDismissKeyboard()
        self.setUpNavigationTitleView()
        self.setUpBottomBtn()
        self.setUpTableView()
        self.navigationItemWhiteColorAndNotLine()
        self.fd_prefersNavigationBarHidden = true
        self.talKingDataPageName = "Order-ApplyMeet"
    
        // Do any additional setup after loading the view.
    }

    func setUpNavigationTitleView() {
        navigationBarTitleView = UIView(frame:CGRectMake(0,0,ScreenWidth, 84))
        navigationBarTitleView.backgroundColor = UIColor.whiteColor()
        self.setNavigationItem()
        lineLabel = UILabel(frame: CGRectMake(0,83.5,ScreenWidth,0.5))
        lineLabel.backgroundColor = UIColor.init(hexString: lineLabelBackgroundColor)
        navigationBarTitleView.addSubview(lineLabel)
        self.setUpTitleView()
        self.view.addSubview(navigationBarTitleView)
        
    }
    
    func setNavigationItem(){
        leftButton = UIButton(type: .Custom)
        leftButton.frame = CGRectMake(20, 30, 20, 20)
        leftButton.setImage(UIImage.init(named: "navigationbar_back")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        leftButton.addTarget(self, action: #selector(ApplyMeetViewController.leftBarPress(_:)), forControlEvents: .TouchUpInside)
        navigationBarTitleView.addSubview(leftButton)
        
    }

    func leftBarPress(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setUpTableView(){
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.separatorStyle = .None
        self.tableView.keyboardDismissMode = .OnDrag
        self.tableView.backgroundColor = UIColor.init(hexString: TableViewBackGroundColor)
        self.tableView.registerClass(OrderFlowTableViewCell.self, forCellReuseIdentifier: "OrderFlowTableViewCell")
        self.tableView.registerClass(OrderApplyMeetTableViewCell.self, forCellReuseIdentifier: "OrderApplyMeetTableViewCell")
        self.tableView.registerClass(OrderApplyIntroductionCell.self, forCellReuseIdentifier: "OrderApplyIntroductionCell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.registerNib(UINib.init(nibName: "OrderApplyInfoTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "OrderApplyInfoTableViewCell")
        self.tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.navigationBarTitleView.snp_bottom).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.bottomBtn.snp_top).offset(0)
        }
        self.tableView.backgroundColor = UIColor.init(hexString: TableViewBackGroundColor)
    }
    
    
    func setUpTitleView(){
        
        titleView = UIView(frame: CGRectMake(40,22,ScreenWidth - 80,63))
        let phototView = UIImageView(frame: CGRectMake((titleView.frame.size.width - PhotoWith)/2, 2, PhotoWith, PhotoHeight))
        phototView.layer.cornerRadius = PhotoWith/2
        phototView.layer.masksToBounds = true
        let imageArray = avater.componentsSeparatedByString("?")
        phototView.sd_setImageWithURL(NSURL.init(string: imageArray[0].stringByAppendingString(NavigaitonAvatarImageSize)), placeholderImage: UIImage.init(color: UIColor.init(hexString: PlaceholderImageColor), size: CGSizeMake(PhotoWith, PhotoHeight)), options: .RetryFailed)
        titleView.addSubview(phototView)
        
        let positionLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(phototView.frame) + 3, titleView.frame.size.width, 16))
        let positionString = "\(realName) \(jobLabel)"
        let attributedString = NSMutableAttributedString(string: positionString)
        attributedString.addAttributes([NSFontAttributeName:AppointRealNameLabelFont!], range: NSRange.init(location: 0, length: realName.length))
        attributedString.addAttributes([NSFontAttributeName:AppointPositionLabelFont!], range: NSRange.init(location: realName.length + 1, length: jobLabel.length))
        attributedString.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: HomeDetailViewNameColor)], range: NSRange.init(location: 0, length: positionString.length))
        positionLabel.attributedText = attributedString
        positionLabel.textAlignment = .Center
        titleView.addSubview(positionLabel)
        navigationBarTitleView.addSubview(titleView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func senderApplyMeet(sender:UIButton){
        if !UserInfo.isLoggedIn() {
            self.persenterLoginView()
        }else{
            self.applyMeet()
        }
    }
    
    func applyMeet() {
        if isApplyOrder {
            UITools.showMessageToView(self.view, message: "预约提交中请稍后", autoHide: true)
            return
        }
        viewModel = OrderViewModel()
        var appointment_theme = ""
        for idx in 0...cell.interestView.selectItems.count - 1 {
            let ret = cell.interestView.selectItems[idx]
            if ret as! String == "true" {
                appointment_theme = appointment_theme.stringByAppendingString(((ProfileKeyAndValue.shareInstance().appDic as NSDictionary).objectForKey("invitation")?.objectForKey("\(allItems[idx])"))! as! String)
                appointment_theme = appointment_theme.stringByAppendingString(",")
                
            }
        }
        if appointment_theme == "" {
            UITools.showMessageToView(self.view, message: "未选择约见形式哦", autoHide: true)
            return
        }
        if introductionCell.textView.text == "" {
            UITools.showMessageToView(self.view, message: "未填写约见说明哦", autoHide: true)
            return
        }
        isApplyOrder = true
        let applyModel = ApplyMeetModel()
        applyModel.appointment_desc = introductionCell.textView.text;
        applyModel.appointment_theme = appointment_theme
        applyModel.host = self.host
        applyModel.guest = UserInfo.sharedInstance().uid
        viewModel.applyMeetOrder(applyModel, successBlock: { (dic) in
            let orderDic = dic as NSDictionary
            self.viewModel.orderDetail(orderDic.objectForKey("order_id") as! String, successBlock: { (dic) in
                let orderModel = OrderModel.mj_objectWithKeyValues(dic["order"])
            NSUserDefaults.standardUserDefaults().setObject(dic["customer_service_number"], forKey: "customer_service_number")
                let applyDetailView = ConfirmedViewController()
                applyDetailView.uid = self.host
                applyDetailView.isAppliViewPush = true
                applyDetailView.orderModel = orderModel
                self.navigationController?.pushViewController(applyDetailView, animated: true)
                }, fialBlock: { (dic) in
                    
            })
            self.isApplyOrder = false
        }) { (dic) in
            let failDic = dic as NSDictionary
            UITools.showMessageToView(self.view, message:failDic.objectForKey("error") as! String, autoHide: true)
            self.isApplyOrder = false
        }
    }
    
    func persenterLoginView() {
        loginView = LoginView(frame: CGRectMake(0,0,ScreenWidth,ScreenHeight))
        let windown = UIApplication.sharedApplication().keyWindow
        windown!.addSubview(loginView)
        loginView.applyCodeClouse = { _ in
            let applyCode = Stroyboard("Login", viewControllerId: "ApplyCodeViewController") as! ApplyCodeViewController
            applyCode.isApplyCode = true
            applyCode.showToolsBlock = { _ in
                UITools.showMessageToView(self.view, message: "申请成功，请耐心等待审核结果^_^", autoHide: true)
                self.loginView.removeFromSuperview()
                UserInfo.logout()
            }
            applyCode.loginViewBlock = { _ in
                self.loginView.showViewWithTage(1)
                UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self.loginView)
            }
            UIApplication.sharedApplication().keyWindow?.sendSubviewToBack(self.loginView)
            self.navigationController?.pushViewController(applyCode, animated: true)
        }
        
        loginView.protocolClouse = { _ in
            let userProtocol = Stroyboard("Seting", viewControllerId: "UserProtocolViewController") as! UserProtocolViewController
            userProtocol.block = { _ in
                self.loginView.mobileTextField.becomeFirstResponder()
                UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self.loginView)
            }
            self.navigationController?.pushViewController(userProtocol, animated: true)
            UIApplication.sharedApplication().keyWindow?.sendSubviewToBack(self.loginView)
        }
        
        loginView.newUserLoginClouse = { _ in
            let baseUserInfo =  Stroyboard("Me", viewControllerId: "BaseInfoViewController") as! BaseUserInfoViewController
            baseUserInfo.isHomeListViewLogin = true
            baseUserInfo.applyMeeBlock = { _ in
                self.applyMeet()
            }
            self.navigationController?.pushViewController(baseUserInfo, animated: true)
        }
        
        loginView.loginWithOrderListClouse = { _ in
            self.applyMeet()
        }
    }
    
    func setUpBottomBtn() {
        bottomBtn = UIButton()
        bottomBtn.setBackgroundImage(UIImage.init(color: UIColor.init(hexString: HomeViewDetailMeetButtonBack), size: CGSizeMake(ScreenWidth, 49)), forState: .Normal)
        bottomBtn.setBackgroundImage(UIImage.init(color: UIColor.init(hexString: HomeViewDetailMeetButtonHightBack), size: CGSizeMake(ScreenWidth, 49)), forState: .Highlighted)
        bottomBtn.addTarget(self, action: #selector(ApplyMeetViewController.senderApplyMeet(_:)), forControlEvents: .TouchUpInside)
        bottomBtn.setTitle("提交申请", forState: .Normal)
        bottomBtn.titleLabel?.font = MeetDetailImmitdtFont
        self.view.addSubview(bottomBtn)
        
        bottomBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
            make.height.equalTo(49)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setData(cell:OrderApplyMeetTableViewCell) {
        if allItems.count > 0 {
            cell.setData(allItems.copy() as! NSArray, selectItems: selectItems.copy() as! NSArray)
        }
    }
    
    
    func updataTableViewContent(textViewHeight:CGFloat) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0))
        if textViewHeight > 80 {
            tableView.setContentOffset(CGPointMake(0, textViewHeight + ((cell?.contentView.frame.size.height)! - 149)), animated: true)
        }
    }
    
    

}

extension ApplyMeetViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 108
            }else{
                return tableView.fd_heightForCellWithIdentifier("OrderApplyMeetTableViewCell", configuration: { (cell) in
                    self.setData(cell as! OrderApplyMeetTableViewCell)
                })
            }
        }else{
            if indexPath.row == 0 {
                return 291
            }else{
                 return 274
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
}

extension ApplyMeetViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderFlowTableViewCell", forIndexPath: indexPath) as! OrderFlowTableViewCell
                cell.selectionStyle = .None
                cell.setData("0", statusType: "apply_order")
                return cell
            }else{
                let cellId = "OrderApplyMeetTableViewCell"
                cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! OrderApplyMeetTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                self.setData(cell)
                return cell
            }
        }else{
            if indexPath.row == 0 {
                let cellId = "OrderApplyIntroductionCell"
                introductionCell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! OrderApplyIntroductionCell
                introductionCell.setData("\((PlaceholderText.shareInstance().appDic as NSDictionary).objectForKey("1000002")!)")
                introductionCell.textView.delegate = self
                introductionCell.textView.scrollEnabled = false
                introductionCell.selectionStyle = UITableViewCellSelectionStyle.None
                introductionCell.numberText.hidden = true
                return introductionCell
            }else{
                let cellId = "OrderApplyInfoTableViewCell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! OrderApplyInfoTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                (PlaceholderText.shareInstance().appDic as NSDictionary).objectForKey("1000003")
                cell.setData("\((PlaceholderText.shareInstance().appDic as NSDictionary).objectForKey("1000003")!)")
                return cell
            }
        }
    }
}

extension ApplyMeetViewController : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        contenOfY = self.tableView.contentOffset.y
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        self.updataTableViewContent(contenOfY)
        let length = 300 - textView.text.length
        introductionCell.numberText.text = "\(length)"
        if textView.text.length > 280 {
            introductionCell.numberText.hidden = false
        }else{
            introductionCell.numberText.hidden = true
        }
        return true
    }
    
}
