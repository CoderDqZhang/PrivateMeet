//
//  HightLightViewController.swift
//  Meet
//
//  Created by Zhang on 9/1/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import UIKit

class HightLightViewController: UIViewController {

    var titleText:UITextView!
    var infoText:UITextView!
    
    var titleStr:String = ""
    var infoStr:String = ""
    var tableView:UITableView!
    

    let viewModel = UserInfoViewModel()
    
    var titleHeight:CGFloat = 192.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItemBack()
        self.title = "编辑个人介绍"
        self.setUpNavigationItem()
        self.setupForDismissKeyboard()
        self.setUpTableView()
        self.talKingDataPageName = "Me-HightLight"
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationItem() {
        let str = (titleStr != "" && infoStr == "") ? "提交":"保存"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: str, style: .plain, target: self, action: #selector(HightLightViewController.sublimTitle(_:)))
        self.changeNavigationBarItemColor()
    }

    func changeNavigationTitleColor() -> Bool {
        
        titleHeight = ((PlaceholderText.shareInstance().appDic as NSDictionary).object(forKey: "1000007") as! String).heightWithConstrainedWidth(ScreenWidth - 40, font: HightLightTitleFont!) + 75
        if titleStr == "" || infoStr == "" {
            return false
        }else{
            return true
        }
    }
    
    func changeNavigationBarItemColor() {
        self.navigationItem.rightBarButtonItem?.tintColor = self.changeNavigationTitleColor() ? UIColor.init(hexString:NavigationBarTintColorCustome) : UIColor.init(hexString:NavigationBarTintDisColorCustom)
    }
    
    func sublimTitle(_ sender:UIBarButtonItem) {
        if titleText.text == "" {
            MainThreadAlertShow("您未填写破冰话题哦", view: self.view)
        }else if infoText.text == "" {
            MainThreadAlertShow("您未填写详细个人介绍哦", view: self.view)
        }else{
            viewModel.addStar(infoText.text, experience: titleText.text, success: { (dic) in
                UserExtenModel.shareInstance().highlight = self.infoText.text
                UserExtenModel.shareInstance().experience = self.titleText.text
                _ = self.navigationController?.popViewController(animated: true)
                }, fail: { (dic) in
                    MainThreadAlertShow((dic?["error"] as! String), view: self.view)
                }, loadingString: { (msg) in
                    
            })
        }
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HightLightViewController: UITableViewDelegate {
    
}

extension HightLightViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath as NSIndexPath).row {
        case 0:
            return titleHeight
        default:
            return ScreenHeight - titleHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).row {
        case 0:
            let cellIndef = "titleCellIndf"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIndef)
            }
            
            titleText = UITextView()
            
            titleText.placeholder = (PlaceholderText.shareInstance().appDic as NSDictionary).object(forKey: "1000007") as! String
            if titleStr != "" {
                titleText.text = titleStr
            }
            titleText.tintColor = UIColor.init(hexString: MeProfileCollectViewItemSelect)
            titleText.delegate = self
            titleText.tag = 1
            titleText.returnKeyType = .done
            titleText.placeholderColor = UIColor.init(hexString: PlaceholderTextViewColor)
            titleText.font = HightLightTitleFont
            cell?.contentView.addSubview(titleText)
            titleText.snp.makeConstraints({ (make) in
                make.top.equalTo((cell?.contentView.snp.top)!).offset(30)
                make.left.equalTo((cell?.contentView.snp.left)!).offset(15)
                make.right.equalTo((cell?.contentView.snp.right)!).offset(-15)
                make.bottom.equalTo((cell?.contentView.snp.bottom)!).offset(-30)
            })

            cell?.selectionStyle = .none
            let line = UILabel()
            line.backgroundColor = UIColor.init(hexString: lineLabelBackgroundColor)
            cell?.contentView.addSubview(line)
            line.snp.makeConstraints({ (make) in
                make.height.equalTo(0.5)
                make.left.equalTo((cell?.contentView.snp.left)!).offset(15)
                make.right.equalTo((cell?.contentView.snp.right)!).offset(-15)
                make.bottom.equalTo((cell?.contentView.snp.bottom)!).offset(0)

            })
            return cell!
        default:
            let cellIndef = "infoCellIndf"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIndef)
            }
            
            infoText = UITextView()
            infoText.placeholder = (PlaceholderText.shareInstance().appDic as NSDictionary).object(forKey: "1000008") as! String
            if infoStr != "" {
                infoText.text = infoStr
            }
            
            infoText.font = HightLightInfoFont
            infoText.delegate = self
            infoText.tag = 2
            infoText.textColor = UIColor.init(hexString: HomeDetailViewNameColor)
            infoText.tintColor = UIColor.init(hexString: MeProfileCollectViewItemSelect)
            infoText.placeholderColor = UIColor.init(hexString: PlaceholderTextViewColor)
            cell?.contentView.addSubview(infoText)
            infoText.snp.makeConstraints({ (make) in
                make.top.equalTo((cell?.contentView.snp.top)!).offset(30.5)
                make.left.equalTo((cell?.contentView.snp.left)!).offset(15)
                make.right.equalTo((cell?.contentView.snp.right)!).offset(-15)
                make.bottom.equalTo((cell?.contentView.snp.bottom)!).offset(-20)
            })
            cell?.selectionStyle = .none

            return cell!
        }
    }
}

extension HightLightViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if infoStr == "" && textView.tag == 2 {
            textView.text = "我是\(UserInfo.sharedInstance().real_name!)，"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" && textView.tag == 1 {
            textView.resignFirstResponder()
            return false
        }
        
        if textView.tag == 1 {
            titleStr = textView.text
            if text == "" && titleStr.length == 1 {
                titleStr = ""
            }else if titleStr.length == 0{
                titleStr = ""
            }
        }else{
            infoStr = textView.text
            if text == "" && infoStr.length == 1 {
                infoStr = ""
            }else if titleStr.length == 0{
                infoStr = ""
            }
        }
        self.changeNavigationBarItemColor()
        return true
    }
}
