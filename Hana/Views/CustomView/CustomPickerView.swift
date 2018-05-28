//
//  CustomPickerView.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/28.
//

import UIKit

class CustomPickerView: UIView {
    
    fileprivate static let pickerHeight: CGFloat = 162
    fileprivate var datePickerView: UIDatePicker!
    fileprivate var pickerView: UIPickerView!
    fileprivate var dataSource: [String]!

    var closure: ((String)-> Void)!
    var dateClosure: ((Date)-> Void)!

    static func showDatePicker(closure: @escaping (Date)-> Void) {
        let width = UIScreen.main.bounds.width
        let offsetY = UIScreen.main.bounds.height - pickerHeight
        let pickerView = CustomPickerView(frame: CGRect(x: 0, y: offsetY, width: width, height: pickerHeight))
        pickerView.dateClosure = closure
        UIApplication.shared.keyWindow?.addSubview(pickerView)
    }
    
    
    static func show(with dataSource: [String], closure: @escaping (String)-> Void) {
        let width = UIScreen.main.bounds.width
        let offsetY = UIScreen.main.bounds.height - pickerHeight
        let pickerView = CustomPickerView(frame: CGRect(x: 0, y: offsetY, width: width, height: pickerHeight))
        pickerView.dataSource = dataSource
        pickerView.closure = closure
        UIApplication.shared.keyWindow?.addSubview(pickerView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        if dataSource == nil {
            datePickerView = UIDatePicker(frame: self.bounds)
            datePickerView.addTarget(self, action: #selector(pickerDidChanged(_:)), for: .editingChanged)
            datePickerView.datePickerMode = .date
            addSubview(datePickerView)
        } else {
            pickerView = UIPickerView(frame: self.bounds)
            pickerView.delegate = self
            pickerView.dataSource = self
            addSubview(pickerView)
        }
    }
    
    @objc func pickerDidChanged(_ sender: UIDatePicker) {
        dateClosure(sender.date)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension CustomPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
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
        closure(dataSource[row])
    }
}

