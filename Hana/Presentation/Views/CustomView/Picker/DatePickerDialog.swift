//
//  DatePickerDialog.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/18.
//

import UIKit

class DatePickerDialog: UIView {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var closure: ((Date?) -> Void)!
    
    
    class func show(_ title: String = "",
              okButtonTitle: String = "Done",
              cancelButtonTitle: String = "Cancel",
              defaultDate: Date = Date(),
              minimumDate: Date? = nil, maximumDate: Date? = nil,
              datePickerMode: UIDatePickerMode = .dateAndTime,
              closure: @escaping (Date?) -> Void) {
        
        if let dateDialogView = Bundle.main.loadNibNamed("DatePickerDialog", owner: nil, options: nil)?.first as? DatePickerDialog {
            dateDialogView.frame = UIScreen.main.bounds
            dateDialogView.datePicker.datePickerMode = datePickerMode
            dateDialogView.closure = closure
            UIApplication.shared.keyWindow?.addSubview(dateDialogView)
            dateDialogView.showAnimation()
        }
    }
    
    func showAnimation() {
        
//        self.dialogView.layer.shouldRasterize = true
//        self.dialogView.layer.rasterizationScale = UIScreen.main.scale
//
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.dialogView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        self.dialogView.layer.opacity = 0.5
//
//        self.dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        /* Anim */
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.dialogView!.layer.opacity = 1
                //self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.dialogView.transform = CGAffineTransform.init(scaleX: 1, y: 1)

            }
        )
    }
    
    func dismissAnimation() {
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.dialogView.layer.opacity = 0.5
                self.dialogView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        }) { (isFinish) in
            if isFinish {
                self.removeFromSuperview()
            }
        }
    }
    
    
    @IBAction func tappedCancel(_ sender: UIButton) {
        dismissAnimation()
    }
    
    @IBAction func tappedOk(_ sender: UIButton) {
        closure(datePicker.date)
        dismissAnimation()
    }
    
    
}

/**
 
 UIView.animate(
 withDuration: 0.2,
 delay: 0,
 options: [],
 animations: {
 self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
 let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
 self.dialogView.layer.transform = transform
 self.dialogView.layer.opacity = 0
 }) { (_) in
 for v in self.subviews {
 v.removeFromSuperview()
 }
 
 self.removeFromSuperview()
 self.setupView()
 }
 
 */
