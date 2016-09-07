//
//  Speaker.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/12/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import AVFoundation

open class Speaker: NSObject {

    open var isSpeaking: Bool {
        get {
            return synthesizer.isSpeaking
        }
    }
    fileprivate var synthesizer: AVSpeechSynthesizer!
    fileprivate var completion: (() -> Void)?

    public override init() {
        self.synthesizer = AVSpeechSynthesizer()
        super.init()
        self.synthesizer.delegate = self
    }

    open func speak(_ text: String, language: String = "en-US", rate: Float = 0.2, completion: (() -> Void)?) {
        if !self.isSpeaking {
            self.completion = completion
            let utterance = AVSpeechUtterance(string: text)
            utterance.rate = rate
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            self.synthesizer.speak(utterance)
        }
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.completion?()
    }
}
