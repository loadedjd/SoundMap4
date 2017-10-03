//
//  DeviceSettingsController.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/14/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class DeviceSettingsController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    private var devicePicker: UIPickerView!
    private var databaseField: UITextField!
    private var devices: [String]!
    private var saveButton: UIButton!
    private var tapRecognizer: UITapGestureRecognizer!
    private var doneButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.devicePicker = UIPickerView()
        self.devices = ["iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8", "iPhone SE", "iPhone 5C"]
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewWasTapped))
        self.saveButton = UIButton(frame: CGRect(x: self.view.frame.width / 2, y: self.view.frame.height, width: self.view.frame.width, height: 10))
        self.databaseField = UITextField()
        self.setupView()
        self.setupConstraints()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addGestureRecognizer(self.tapRecognizer)
        self.view.addSubview(self.devicePicker)
        self.view.addSubview(self.saveButton)
        self.view.addSubview(self.databaseField)
        self.navigationController?.navigationBar.topItem?.title = "Device Settings"
        self.navigationController?.navigationBar.barTintColor = UIColor.red

        
        self.devicePicker.delegate = self
        self.devicePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.saveButton.setBackgroundImage(#imageLiteral(resourceName: "Rectangle"), for: .normal)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.addTarget(self, action: #selector(self.saveButtonWasPressed), for: .touchUpInside)
        
        self.databaseField.placeholder = "Enter database code"
        self.databaseField.delegate = self
        self.databaseField.translatesAutoresizingMaskIntoConstraints = false
        self.databaseField.textAlignment = .center
        if let code = CoreDataManager.sharedInstance.retrieveSettingData().databaseCode {
            self.databaseField.text = code
        }
        
        if let device = CoreDataManager.sharedInstance.retrieveSettingData().deviceType {
           var index = self.devices.index(of: device)
            self.devicePicker.selectRow(index!, inComponent: 0, animated: true)
        }
        
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonWasPressed))
        self.doneButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = self.doneButton
    }
    
    func setupConstraints() {
        self.saveButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.devicePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.databaseField.topAnchor.constraint(equalTo: self.devicePicker.bottomAnchor, constant: 8).isActive = true
        self.databaseField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
   @objc func saveButtonWasPressed() {
    
    
        CoreDataManager.sharedInstance.updateSettingData(databaseCode: self.databaseField.text!, deviceType: self.devices[self.devicePicker.selectedRow(inComponent: 0)])
        self.dismiss(animated: true, completion: nil)
    
        if CoreDataManager.sharedInstance.retrieveSettingData().databaseCode == "BUCKS" {
            FirebaseManager.sharedInstance.getData(path: "") {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "reloadData")))
            }
        }
    
        else {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "reloadData")))
        }
    
    }
    
    @objc func doneButtonWasPressed() {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func viewWasTapped() {
        self.databaseField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
