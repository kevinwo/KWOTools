//
//  Speaker.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/12/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import AVFoundation

public class Speaker: NSObject {

    public var isSpeaking: Bool {
        get {
            return synthesizer.speaking
        }
    }
    private var synthesizer: AVSpeechSynthesizer!
    private var completion: (() -> Void)?

    public override init() {
        self.synthesizer = AVSpeechSynthesizer()
        super.init()
        self.synthesizer.delegate = self
    }

    public func speak(text: String, language: String = "en-US", rate: Float = 0.2, completion: () -> Void) {
        if !self.isSpeaking {
            self.completion = completion
            let utterance = AVSpeechUtterance(string: text)
            utterance.rate = rate
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            self.synthesizer.speakUtterance(utterance)
        }
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    public func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        self.completion?()
    }
}
