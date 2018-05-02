//
//  SoundsTableViewController.swift
//  TalkBoy
//
//  Created by Ivaylo Yosifov on 1/5/18.
//  Copyright © 2018 Ivaylo Yosifov. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsTableViewController: UITableViewController {

    var sounds : [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        }
        
    override func viewWillAppear(_ animated: Bool) {
        getSounds()
     
    }

    func getSounds() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataStuff = try? context.fetch(Sound.fetchRequest()) as? [Sound] {
                if let coreDataItems = coreDataStuff {
                    sounds = coreDataItems
                    tableView.reloadData()
                }
            }
        }
    }

   

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sounds.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainReusableCell", for: indexPath)

        let sound   = sounds[indexPath.row]
        cell.textLabel?.text = sound.title


        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        let audioPlayer = try? AVAudioPlayer(data: sound.audioData!)
        audioPlayer?.play()
        tableView.deselectRow(at: indexPath, animated: true)
    }

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

 
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sound = sounds[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(sound)
                getSounds()
            }
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
