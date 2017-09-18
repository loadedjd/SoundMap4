//
//  NewRecordController.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/13/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class NewRecordController: UIViewController {
    
    
    private var decibelLabel: UILabel!
    private var locationLabel: UILabel!
    private var timeStampLabel: UILabel!
    private var doneBarButton: UIBarButtonItem!
    private var recordButton: UIButton!
    private var audioManager: AudioManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setConstraints()
        
        self.audioManager = AudioManager()
    }
    
    func setupView() {
        
        self.decibelLabel = UILabel()
        self.decibelLabel.text = " :dB"
        self.decibelLabel.translatesAutoresizingMaskIntoConstraints = false
        decibelLabel.font = UIFont.systemFont(ofSize: 50)
        
        
        self.doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonPressed))
        
        self.recordButton = UIButton()
        self.recordButton.setBackgroundImage(#imageLiteral(resourceName: "Rectangle"), for: .normal)
        self.recordButton.setTitle("Record", for: .normal)
        self.recordButton.addTarget(self, action: #selector(self.recordButtonPressed), for: .touchUpInside)
        self.recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.decibelLabel)
        self.view.addSubview(self.recordButton)
        self.navigationItem.rightBarButtonItem = self.doneBarButton
        
        self.navigationController?.navigationBar.topItem?.title = "New Record"
        self.view.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: NSNotification.Name(rawValue: "updateAudio"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.recordingDone), name: NSNotification.Name(rawValue: "recordingDone"), object: nil)
    }
    
    func setConstraints() {
        self.recordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.recordButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.decibelLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.decibelLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func recordButtonPressed() {
        self.doneBarButton.isEnabled = false
        self.recordButton.isEnabled = false
        self.audioManager.startRecording()
    }
    
    
    @objc func updateView() {
        guard let sample = self.audioManager.samples.last else { return }
        var color: UIColor
        
        
        if (Double(sample) < 60) {
            color = UIColor.green
        }
        
       else if (Double(sample) >= 60 && Double(sample) < 80 ) {
            color = UIColor.yellow
        }
        
        else {
            color = UIColor.red
        }
        
        self.decibelLabel.textColor = color
        self.decibelLabel.text = "\(sample) dB"
    }
    
    @objc func recordingDone() {
        self.dismiss(animated: true, completion: nil)
        let record = constructRecord()
        FirebaseManager.sharedInstance.postDataToDatabase(recordData: record)
        CoreDataManager.sharedInstance.updatePoints()
    }
    
    func constructRecord() -> DataRecord {
        let lat = String(describing: (LocationManager.sharedInstance.currentLocation?.coordinate.latitude)!)
        let long = String(describing: (LocationManager.sharedInstance.currentLocation?.coordinate.longitude)!)
        let decibelAverage = String(describing: self.audioManager.logAverage!).truncate(length: 5)
        
        timeDate.updateDate()
        let time = timeDate.timeStamp
        
        let record = DataRecord(decibel: decibelAverage, lat: lat, long: long, time: time)
        return record
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
