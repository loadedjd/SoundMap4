//
//  SettingsCell.swift
//  SoundMap3
//
//  Created by Jared Williams on 8/31/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var databaseLabel: UILabel?
    private var cellImage: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    
        
    }
    
    func setupView() {
        
        
        self.databaseLabel = UILabel()
        self.databaseLabel?.font = UIFont.systemFont(ofSize: 15)
        self.databaseLabel?.textColor = UIColor.gray
        self.databaseLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        self.cellImage = UIImageView(image: #imageLiteral(resourceName: "if_settings_115801"))
        self.cellImage?.clipsToBounds = true
        self.cellImage?.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.cellImage!)
        self.contentView.addSubview(self.databaseLabel!)
        
        
    }
    
    func setupConstraints() {
        self.databaseLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.databaseLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.cellImage?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.cellImage?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setCellText(text: String) {
        self.databaseLabel?.text = text
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.setupView()
        self.setupConstraints()
    }

}
