//
//  AddTappedViewController.swift
//  TalkBoy
//
//  Created by Ivaylo Yosifov on 1/5/18.
//  Copyright © 2018 Ivaylo Yosifov. All rights reserved.
//

import UIKit
import AVFoundation

class CreateSoundViewController: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Audio Session
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        //URL to save audio
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let pathComponents = [basePath, "audio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
     
                //Create some settings
        
        
        
                //Create the audio recorder
        
                audioRecorder = AVAudioRecorder(url: audioURL, settings: <#T##[String : Any]#>)
                audioRecorder?.prepareToRecord()
                
            }
        }
    }
    
    
    
    @IBAction func recordTapped(_ sender: Any) {
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    
    
}
