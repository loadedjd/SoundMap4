//
//  DeviceSettingsController.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/14/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class DeviceSettingsController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var devicePicker: UIPickerView!
    private var devices: [String]!
    private var saveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.devicePicker = UIPickerView()
        self.devices = ["iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8", "iPhone SE", "iPhone 5C"]
        self.saveButton = UIButton(frame: CGRect(x: self.view.frame.width / 2, y: self.view.frame.height, width: self.view.frame.width, height: 10))
        self.setupView()
        self.setupConstraints()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.devicePicker)
        self.view.addSubview(self.saveButton)
        self.navigationController?.navigationBar.topItem?.title = "Device Settings"
        
        self.devicePicker.delegate = self
        self.devicePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.saveButton.setBackgroundImage(#imageLiteral(resourceName: "Rectangle"), for: .normal)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.addTarget(self, action: #selector(self.saveButtonWasPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        self.saveButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.devicePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func saveButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.devices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devices[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
