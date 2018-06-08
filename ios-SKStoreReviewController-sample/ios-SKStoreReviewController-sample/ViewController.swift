//
//  ViewController.swift
//  ios-SKStoreReviewController-sample
//
//  Created by ogasawara_dev on 2018/06/08.
//  Copyright © 2018年 ogasawara_dev. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showReviewAlert()
    }
    // MARK: SKStoreReviewController
    // reference: https://qiita.com/asashin227/items/f0c44821020af6ee846d
    
    /// レビュー依頼ダイアログを表示する
    /// NOTE: iOS10.3以上対象
    private func showReviewAlert() {
        if #available(iOS 10.3, *) {
            // iOS 10.3以上の処理
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/id{アプリのID}?action=write-review") {
            // iOS 10.3未満の処理
            showAlertController(url: url)
        }
        
    }
    /// iOS10.3未満の場合のレビューのお願いを表示する
    ///
    /// - Parameter url: レビューを依頼したいアプリのURL
    private func showAlertController(url: URL) {
        let alert = UIAlertController(title: "レビューのお願い",
                                      message: "いつもありがとうございます！\nレビューをお願いします！",
                                      preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let cancelAction = UIAlertAction(title: "キャンセル",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelAction)
        let reviewAction = UIAlertAction(title: "レビューする",
                                         style: .default,
                                         handler: {
                                            (action:UIAlertAction!) -> Void in
                                            if #available(iOS 10.0, *) {
                                                UIApplication.shared.open(url, options: [:])
                                            }
                                            else {
                                                UIApplication.shared.openURL(url)
                                            }
                                            
        })
        alert.addAction(reviewAction)
    }


}

