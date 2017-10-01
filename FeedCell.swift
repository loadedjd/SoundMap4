//
//  FeedCell.swift
//  SoundMap3
//
//  Created by Jared Williams on 7/29/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    
    private var decibelLabel: UILabel?
    private var timeLabel: UILabel?
    private var locationLabel: UILabel?
    private var colorView: UIView?
    private var seperatorView: UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.decibelLabel = UILabel()
        self.decibelLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.decibelLabel?.textColor = UIColor.black
        self.decibelLabel?.font = UIFont.systemFont(ofSize: 30)
        self.addSubview(self.decibelLabel!)
        
        self.timeLabel = UILabel()
        self.timeLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel?.textColor = UIColor.black
        self.timeLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(self.timeLabel!)
        
        self.locationLabel = UILabel()
        self.locationLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel?.textColor = UIColor.black
        self.locationLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(self.locationLabel!)
        
        self.colorView = UIView(frame:  CGRect(x: 8, y: 8 , width: 20, height: 20))
        self.colorView?.backgroundColor = UIColor.red
        self.colorView?.layer.cornerRadius = (self.colorView?.frame.width)! / 2
        self.addSubview(self.colorView!)
        
        self.seperatorView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
        self.seperatorView?.backgroundColor = UIColor.black
        self.seperatorView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.seperatorView!)
    }

    func setupConstraints() {
        
        self.decibelLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.decibelLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.timeLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.timeLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.locationLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.locationLabel?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        //self.colorView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        //self.colorView?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        
    }
    
    func setLocationLabel(text: String) {
        self.locationLabel?.text = text
    }
    
    func setTimeLabel(text: String) {
        self.timeLabel?.text = text
    }
    
    func setDecibel(text: String) {
        self.decibelLabel?.text = "\(text) DB"
    }
    
    func setColorView(color: UIColor) {
        self.colorView?.backgroundColor = color
    }
}
