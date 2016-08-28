//
//  FirstViewController.swift
//  moyopi
//
//  Created by Keishi Mitsuhashi on 2016/08/28.
//  Copyright © 2016年 kebabees. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEventDate: UITextField!
    @IBOutlet weak var txtEventPlace: UITextField!
    @IBOutlet weak var txtEventCapacity: UITextField!
    @IBOutlet weak var txtEventFee: UITextField!
    @IBOutlet weak var lblErrMsg: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapCreate(sender: UIButton) {
        // 入力チェック
        if self.txtEventName.text!.isEmpty || self.txtEventDate.text!.isEmpty || self.txtEventPlace.text!.isEmpty || self.txtEventCapacity.text!.isEmpty || self.txtEventFee.text!.isEmpty {
            self.lblErrMsg.text = "※未入力の項目があります"
            return
        }
        
        let url = "https://moyopi.herokuapp.com/events"
        let parameters = [
            "event_name": txtEventName.text!,
            "event_date": txtEventDate.text!,
            "event_place": txtEventPlace.text!,
            "event_capacity": txtEventCapacity.text!,
            "event_fee": txtEventFee.text!,
            "created_by": "1"
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                print(response)
                if let data: AnyObject = response.result.value {
                    let json = JSON(data)
                    print(json)
                    if let event_name = json["event_name"].string {
                        let myAlert: UIAlertController = UIAlertController(title: "Success", message: "イベント\(event_name)を作成しました", preferredStyle: .Alert)
                        let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                            print("Action OK!!")
                        }
                        myAlert.addAction(myOkAction)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                    } else {
                        var errorMessage: NSString
                        errorMessage = "イベントの作成に失敗しました"
                        /*
                         if json["error_message"].string != nil {
                         errorMessage = json["error_message"].string!
                         } else {
                         errorMessage = "Unknown Error"
                         }
                         */
                        print("error detected")
                        self.lblErrMsg.text = errorMessage as String
                    }
                }
        }
    }
}

