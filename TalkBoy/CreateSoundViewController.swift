//
//  CreateSoundViewController.swift
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
    @IBOutlet weak var errorLabel: UILabel!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Audio Session
        
        let session = AVAudioSession.sharedInstance()
        do {
            try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            //try? session.overrideOutputAudioPort(.speaker)
            try? session.setActive(true)
            session.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.audioURL = self.createNewDocumentPathFileName(fName: "audio.m4a")
                        var recorderSettings : [String:Any] = [:]
                        
                        
                        recorderSettings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                        recorderSettings[AVSampleRateKey] = 12000
                        recorderSettings[AVNumberOfChannelsKey] = 1
                    
                        self.audioRecorder = try? AVAudioRecorder(url: self.audioURL!, settings: recorderSettings)
                        self.audioRecorder?.prepareToRecord()
                        self.playButton.isEnabled = false
                        self.addButton.isEnabled = false
                        self.titleField.isEnabled = false
                    } else {
                        // failed to record!
                        self.errorLabel.text = "The session was not allowed. Go back to the previous screen"
                        self.errorLabel.isEnabled = true
                    }
                }
            }
            //URL to save audio
            /*        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
             let pathComponents = [basePath, "audio.m4a"]
             if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
             */
            
            
            //Create some settings
            
            
            
            //Create the audio recorder
            
            
            
        }
        
        
    }

    
  
    
    @IBAction func recordTapped(_ sender: Any) {
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordButton.setTitle("Record", for: .normal)
                playButton.isEnabled = true
                addButton.isEnabled = true
                titleField.isEnabled = true
            } else {
                audioRecorder.record()
                recordButton.setTitle("Stop", for: .normal)
                playButton.isEnabled = false
                addButton.isEnabled = false
                titleField.isEnabled = false
            }
            
        }
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let sound = Sound(entity: Sound.entity(), insertInto: context)
            sound.title = titleField.text
            sound.audioData = try? Data(contentsOf: audioURL!)
            try? context.save()
            navigationController?.popViewController(animated: true)
            
        }
    }
    

    @IBAction func playTapped(_ sender: Any) {
        if let audioURL = self.audioURL {
            let audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
        
    }
    
    func createNewDocumentPathFileName(fName: String )->URL{
        
        let dirPathNoScheme = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        //add directory path file Scheme;  some operations fail w/out it
        let dirPath = "file://\(dirPathNoScheme)"
        //name your file, make sure you get the ext right .mp3/.wav/.m4a/.mov/.whatever
        //let fileName = "thisIsYourFileName.mov"
        let pathArray = [dirPath, fName]
        let path = URL(string: pathArray.joined(separator: "/"))
        
        //use a guard since the result is an optional
        guard let filePath = path else {
            //if it fails do this stuff:
            return URL(string: "choose how to handle error here")!
        }
        //if it works return the filePath
        return filePath
    }
 
    
   
    
    
    
}
