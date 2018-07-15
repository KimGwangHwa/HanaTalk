//
//  PickerDialog.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/13.
//

import UIKit

class PickerDialog: UIView {
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    var dataSource: [String]!
    var selectedRow: Int = 0
    
    var closure: ((String) -> Void)!
    
    class func show(_ title: String = "",
                    okButtonTitle: String = "Done",
                    cancelButtonTitle: String = "Cancel",
                    dataSource: [String],
                    closure: @escaping (String) -> Void) {
        
        if let dialogView = Bundle.main.loadNibNamed("PickerDialog", owner: nil, options: nil)?.first as? PickerDialog {
            dialogView.frame = UIScreen.main.bounds
            dialogView.closure = closure
            dialogView.dataSource = dataSource
            UIApplication.shared.keyWindow?.addSubview(dialogView)
            dialogView.showAnimation()
        }
    }
    
    override func awakeFromNib() {
        picker.delegate = self
        picker.dataSource = self
    }
    
    func showAnimation() {
        
        self.dialogView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        self.dialogView.layer.opacity = 0.5

        /* Anim */
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.dialogView!.layer.opacity = 1
                self.dialogView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
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
        closure(dataSource[selectedRow])
        dismissAnimation()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension PickerDialog: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}


