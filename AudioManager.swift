//
//  Recorder.swift
//  SoundMap2
//
//  Created by Jared Williams on 3/28/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import AVFoundation


class AudioManager: NSObject, AVAudioRecorderDelegate {
    
    
    var samples = [Float]()
    var logAverage: Float?
    
    
    
    
    let settings: [String: AnyObject] = [AVFormatIDKey: kAudioFormatAppleLossless as AnyObject,
                                         AVSampleRateKey: 44100 as AnyObject,
                                         AVNumberOfChannelsKey: 1 as AnyObject,
                                         AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue as AnyObject]
    
    var recorder: AVAudioRecorder?
    var audioSession: AVAudioSession?
    var recordPermission: Bool?
    var averagePower: Float?
    var timer: Timer?
    var recording: Bool?
    
    override init() {
        super.init()
        self.recording = false
        setup()
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.timer?.invalidate()
        self.recording = false
        self.computeAverageDB()
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "recordingDone")))
        
    }
    
    
    func getDocumentsDirectory() -> URL {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        var path = paths[0] as NSString // Make sure you cast this to NSString because NSSTring gives you the a .appendingPathComponent function, which you need to add the file name to the document directory path
        path = path.appendingPathComponent("SoundMapRecording.m4a") as NSString
        
        return NSURL(fileURLWithPath: path as String) as URL
    }
    
    func setup() {
        
        
        
        self.audioSession = AVAudioSession.sharedInstance() // Have to share the audio with all the other apps
        
        do { try self.audioSession?.setCategory(AVAudioSessionCategoryPlayAndRecord)} catch {print("Couldnt instatntiate session")}
        do { try self.audioSession?.setActive(true) } catch { print("Couldnt Activate Session") }
        
        
        self.audioSession?.requestRecordPermission() { (response) -> Void in {
            if (response) {
                self.recordPermission = true
                self.setupRecorder()
            }
                
            else {
                self.recordPermission = false
            }}()
            
            
        }
        
        
        
    }
    
    
    func setupRecorder() {
        do { try self.recorder = AVAudioRecorder(url: getDocumentsDirectory() , settings: self.settings) } catch { print("Couldnt Instantiate the recorder")}
        self.recorder?.delegate = self
        self.recorder?.prepareToRecord() // Prepares recorder and creates the file we defined
        self.recorder?.isMeteringEnabled = true
    }
    
    func startRecording() {
        self.recording = true
        self.recorder?.record(forDuration: 30)
        self.recorder?.updateMeters()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (block) -> Void in
            self.updateMeters()
        }
        
    }
    
    
    
    
    func updateMeters() {
        self.recorder?.updateMeters()
        let power = self.recorder?.averagePower(forChannel: 0)
        //  print(power)
        self.samples.append(power! + 100)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "updateAudio"), object: nil)
    }
    
    func computeAverageDB() {
        
        var runningSum: Float = 0.0
        
        for sample in self.samples {
            runningSum +=  pow(10.0, sample / 20.0)
        }
        
        runningSum = runningSum / Float(samples.count)
        runningSum = log10(runningSum)
        runningSum *= 20
        self.logAverage = runningSum
    }
    
}

