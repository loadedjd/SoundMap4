//
//  PointController.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/18/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class PointController: UIViewController {
    
    private var doneBarButton: UIBarButtonItem!
    private var pointsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        

    }
    
    func setupView() {
        self.navigationController?.navigationBar.topItem?.title = "Me"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.view.backgroundColor = UIColor.white
        
        self.doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonPressed))
        self.doneBarButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = doneBarButton
        
        self.pointsLabel = UILabel()
        
        if CoreDataManager.sharedInstance.retrieveSettingData().databaseCode == "BUCKS" {
            self.pointsLabel.text = "\(CoreDataManager.sharedInstance.retrieveSettingData().points) Points"
        }
        self.pointsLabel.font = UIFont.systemFont(ofSize: 50)
        self.pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pointsLabel)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.pointsLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.pointsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
