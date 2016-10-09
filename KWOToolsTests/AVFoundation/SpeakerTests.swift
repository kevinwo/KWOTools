//
//  SpeakerTests.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 10/9/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import XCTest
import AVFoundation
@testable import KWOTools

class FakeSpeaker: Speaker {

    var synthesizer: AVSpeechSynthesizer!
}

class SpeakerTests: XCTestCase {

    var speaker: Speaker!

    override func setUp() {
        super.setUp()

        self.speaker = Speaker()
    }

    override func tearDown() {
        self.speaker = nil

        super.tearDown()
    }

    func test_speak_doesUtter_andCallsCompletion() {
        // given
        let text = "Cool text"
        let anExpectation = expectation(description: "Wait for speech")
        var didSpeak = false

        // when
        self.speaker.speak(text) { 
            // then
            anExpectation.fulfill()
            didSpeak = true
        }
        
        waitForExpectations(timeout: 3.0) { (error) in
            if !didSpeak {
                XCTFail()
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
