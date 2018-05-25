//
//  HelperHearsay.swift
//  Chips_Example
//
//  Created by Fajar on 4/19/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

import UIKit
import Sheeeeeeeeet


@objc protocol SheeetDelegate {
    @objc(alertClickedWithReportId:withCommentId:withReason:)
    func alertClicked(reportId:String,commentId:String,reason:String)
}

@objc class HelperHearsay: NSObject {
    
    @objc(test)
    func test(){
        print("test")
    }
    
    @objc(showAlertWithcommentID:withVC:withDelegate:)
    func showAlert(commentID:String,vc:UIViewController,delegate:SheeetDelegate){
        print("From alert");
        let title = ActionSheetTitle(title: "Report Comment");
        let action = ActionSheetSelectItem(title: "It's Spam",isSelected:false,group:"report", value: "1")
        
        let action2 = ActionSheetSelectItem(title: "Harassment, bullying and Violence",isSelected:false,group:"report", value: "3")
        let action3 = ActionSheetSelectItem(title: "Porn and sexual explicit",isSelected:false,group:"report", value: "5")
        let button = ActionSheetOkButton(title: "Report Now")
        let button2 = ActionSheetCancelButton(title: "Cancel")
        let sheet = ActionSheet(items: [title,action,action2,action3,button2]) { (_, item) in
            delegate.alertClicked(reportId: item.value as? String ?? "0", commentId: commentID,reason: item.title)
        }
        sheet.present(in: vc, from: nil)
    }
}
