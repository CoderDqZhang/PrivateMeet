//
//  OrderMeetViewController.swift
//  Meet
//
//  Created by Zhang on 7/30/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import UIKit

class OrderMeetViewController: BaseOrderPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderState = "6"
        self.setOrderData(orderState, guest: UserInfo.sharedInstance().uid)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloaCollectViewData() {
        self.setOrderData(orderState, guest: UserInfo.sharedInstance().uid)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let applyDetailView = WaitMeetViewController()
        let orderModel = (orderList[indexPath.row] as! OrderModel)
        applyDetailView.myClouse = { status in
            self.orderList.removeObjectAtIndex(indexPath.row)
            self.collectionView.reloadData()
        }
        orderModel.appointment_theme = ["吃饭聚餐","看电影","逛街","更多","资深设计","视觉设计"]
        applyDetailView.orderModel = orderModel
        self.navigationController?.pushViewController(applyDetailView, animated: true)
    }

}
