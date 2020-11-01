//
//  SpeechOutput.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import AVFoundation

class SpeechOutput: NSObject {
    
    func say(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.545

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
