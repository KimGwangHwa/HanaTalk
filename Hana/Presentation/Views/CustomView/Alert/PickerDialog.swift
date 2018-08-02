//
//  PickerDialog.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/13.
//

import UIKit

class PickerDialog: NSObject {
    
    var pikcer: UIPickerView!
    var data: [String]!
    var selectedData: String!
    
    var closure: ((String) -> Void)!
    
    class func show(defaultText: String? = nil,
                    dataSource: [String],
                    closure: @escaping (String) -> Void) {
        let dialog = PickerDialog()
        dialog.pikcer = UIPickerView(frame: CGRect.zero)
        dialog.pikcer.delegate = dialog
        dialog.pikcer.dataSource = dialog
        dialog.data = dataSource
        dialog.pikcer.selectRow(dataSource.index(of: defaultText ?? "") ?? 0, inComponent: 0, animated: true)
        dialog.selectedData = defaultText.isBlank ? dataSource.first : defaultText;
        HNAlertView.show(with: dialog.pikcer, okComplection: {
            closure(dialog.selectedData)
        }) {
            
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension PickerDialog: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedData = data[row]
    }
}


