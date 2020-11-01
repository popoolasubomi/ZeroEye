//
//  SpeechOutput.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import AVFoundation

class SpeechOutput: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func say(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.545

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }

}
