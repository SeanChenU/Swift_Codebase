//
//  PickerMaster.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/6/9.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//


class PickerMaster: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    static let sharedInstance = PickerMaster()
    
    var pickersData: [[String: AnyObject]] = [[String: AnyObject]]()
    
    func createPickerForView(textField: UITextField, pickOption: [String]) {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        textField.inputView = picker
        
        pickersData.append([
            pickerKey(): picker,
            pickerOptionKey(): pickOption,
            pickerTextField(): textField
            ])
    }
    
    // MARK: - PICKER DATASOURCE
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let thePickOption = findPickOptionTextFieldByPicker(pickerView).pickerOption
        guard thePickOption != nil else {
            return 0
        }
        return thePickOption!.count
    }
    
    // HELPER
    func findPickOptionTextFieldByPicker(picker: UIPickerView) -> (pickerOption: [String]?, textField: UITextField?) {
        let thePickerData = pickersData.filter { (aPickerData) -> Bool in
            if aPickerData[pickerKey()] as! UIPickerView === picker {
                return true
            }
            return false
        }
        
        if thePickerData.count == 0 {
            return (nil, nil)
        } else {
            return (thePickerData[0][pickerOptionKey()] as? [String], thePickerData[0][pickerTextField()] as? UITextField)
        }
    }
    
    // HELPER
    func pickerKey() -> String {
        return "picker"
    }
    
    // HELPER
    func pickerOptionKey() -> String {
        return "pickerOption"
    }
    
    // HELPER
    func pickerTextField() -> String {
        return "pickerTextField"
    }
    
    // MARK: - PICKER DELEGATE
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerOption = findPickOptionTextFieldByPicker(pickerView).pickerOption
        guard pickerOption != nil else {
            return ""
        }
        return pickerOption![row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let textField = findPickOptionTextFieldByPicker(pickerView).textField
        let option = findPickOptionTextFieldByPicker(pickerView).pickerOption
        guard textField != nil && option != nil else {
            return
        }
        textField!.text = option![row]
    }
    
    // CLEANUP
    func cleanPickers() {
        self.pickersData = []
    }
}
