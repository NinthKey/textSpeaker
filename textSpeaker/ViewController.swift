//
//  ViewController.swift
//  textSpeaker
//
//  Created by KaWing on 2/25/17.
//  Copyright © 2017 KaWing. All rights reserved.
//

import UIKit
import AVFoundation
import AWSPolly

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var global_check = true;
    
    var audioPlayer = AVPlayer()
    var stringController = StringController()
    var queue = Queue<URL>()
    var audioQueue = AVQueuePlayer()
//    
//    @IBAction func PauseAction(_ sender: UIButton) {
//        audioQueue.pause()
//        audioQueue.removeAllItems()
//    
//        
//        
//    }
    
    var newPath = ""
    @IBOutlet weak var tableView: UITableView!
    
    var busy = false
    
    var names = ["ka", "wing","ka", "wing","ka", "wing","ka", "wing","ka", "wing","ka", "wing","ka", "wing","ka", "wing","ka", "wing"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        newPath = path.appending("/pdfs")
        print(newPath)
        do {
            names = try fm.contentsOfDirectory(atPath: newPath)
            
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "prototype") as UITableViewCell!
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = TETDetailViewController()
        detailViewController.fileName = newPath + "/" + names[indexPath.row]
        
        detailViewController.stringController = stringController
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
        
    }

    
    @IBAction func playButtonAction(_ sender: Any) {
        
        let input = AWSPollySynthesizeSpeechURLBuilderRequest()
        let stringToPlay = stringController.removeString()
        

//        input.text = "little bitch mother fucker stupid ass"
//        print("////")
//        print(stringController.size )
        input.text = stringController.removeString()
        print("***")
        print(input.text)
        print("/////")
        input.outputFormat = AWSPollyOutputFormat.mp3
       // stringController.append("HI");
//
        input.voiceId = AWSPollyVoiceId.salli

        let stringArray = stringToPlay?.components(separatedBy: " " )

        
        var finalStringArray = [String]()
        
        var count = 0
        
        for str in stringArray!{
            if(count%10)==0{
                finalStringArray.append("")
            }
            finalStringArray[count/10].append(str)
            
            finalStringArray[count/10].append(" ")
            count+=1
        }
        
        
//        input.text = stringController.removeString()
        
//        input.outputFormat = AWSPollyOutputFormat.mp3
//        input.voiceId = AWSPollyVoiceId.salli
//        
//        // Create an task to synthesize speech using the given synthesis input
//        let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)
//        
//        // Request the URL for synthesis result
//        builder.continueOnSuccessWith { (awsTask: AWSTask<NSURL>) -> Any? in
//            // The result of getPresignedURL task is NSURL.
//            // Again, we ignore the errors in the example.
//            let url = awsTask.result!
//            
//            self.queue.enqueue(url as URL)
//            
////            // Try playing the data using the system AVAudioPlayer
////            self.audioPlayer.replaceCurrentItem(with: AVPlayerItem(url: url as URL))
////            self.audioPlayer.play()
////            
//            return nil
//        }
        
        for str in finalStringArray{
            
            input.text = str
            
            if(global_check == false){
                break;
            }
            
            
            input.outputFormat = AWSPollyOutputFormat.mp3
            input.voiceId = AWSPollyVoiceId.salli
            
            // Create an task to synthesize speech using the given synthesis input
            let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)
            
            // Request the URL for synthesis result
            builder.continueOnSuccessWith { (awsTask: AWSTask<NSURL>) -> Any? in
                // The result of getPresignedURL task is NSURL.
                // Again, we ignore the errors in the example.
                let url = awsTask.result!
                
                self.queue.enqueue(url as URL)
                
                let newasset = AVURLAsset(url: url as URL)
                let avPlayerItem = AVPlayerItem(asset: newasset)
                
                self.audioQueue.insert(avPlayerItem, after: self.audioQueue.items().last)

                if(self.busy == false){
                    self.audioQueue.play()
                    self.busy = true
                }
                
                if(self.audioQueue.items().count == 0){
                    self.busy = false
                }
                
                return nil
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desinationController: CamViewController = segue.destination as! CamViewController
    
        desinationController.stringController = stringController
    }
    
}

