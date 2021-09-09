//
//  YearPickerView.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation
import UIKit

class YearPickerView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBAction func close(_ sender: UIButton) {
        saveActualValue?(components[yearPicker.selectedRow(inComponent: 0)])
        self.removeFromSuperview()
    }
    
    var components: [String] = []
    var saveActualValue: ((String)->())?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "YearPickerView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func setup(_ years: [String]) {
        yearPicker.dataSource = self
        yearPicker.delegate = self
        self.components = years
    }
    
    func defaultSelectedItem(_ item: String) {
        if let index = components.firstIndex(of: item) {
            yearPicker.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
}

extension YearPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        components.count
    }
    
    
}

extension YearPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        components[row]
    }
}
