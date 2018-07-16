//
//  DatePickerDialog.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/18.
//

import UIKit

class DatePickerDialog: NSObject {

    private var datePicker: UIDatePicker!
    
    var closure: ((Date) -> Void)!
    
    class func show(defaultDate: Date = Date(),
              minimumDate: Date? = nil,
              maximumDate: Date? = nil,
              datePickerMode: UIDatePickerMode = .dateAndTime,
              closure: @escaping (Date) -> Void) {
        
        let dialog = DatePickerDialog()
        dialog.datePicker = UIDatePicker(frame: CGRect.zero)
        dialog.datePicker.date = defaultDate
        dialog.datePicker.minimumDate = minimumDate
        dialog.datePicker.maximumDate = maximumDate

        dialog.closure = closure
        
        HNAlertView.show(with: dialog.datePicker, okComplection: {
            closure(dialog.datePicker.date)
        }) {
            
        }
    }
}
