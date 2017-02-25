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


class ViewController: UIViewController {

    var audioPlayer = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func playButtonAction(_ sender: Any) {
        
        let input = AWSPollySynthesizeSpeechURLBuilderRequest()
        
        input.text = "Hello, my name is Joe. I know I'm stupid. Please forgive me. "
        
        input.outputFormat = AWSPollyOutputFormat.mp3
        
        input.voiceId = AWSPollyVoiceId.salli
        
        // Create an task to synthesize speech using the given synthesis input
        let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)
        
        // Request the URL for synthesis result
        builder.continueOnSuccessWith { (awsTask: AWSTask<NSURL>) -> Any? in
            // The result of getPresignedURL task is NSURL.
            // Again, we ignore the errors in the example.
            let url = awsTask.result!
            
            // Try playing the data using the system AVAudioPlayer
            self.audioPlayer.replaceCurrentItem(with: AVPlayerItem(url: url as URL))
            self.audioPlayer.play()
            
            return nil
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

