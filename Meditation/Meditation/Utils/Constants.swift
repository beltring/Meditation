//
//  Constants.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 27.09.21.
//

import Foundation
import UIKit

struct ProgramConstants {
    static func getPrograms() -> [Program] {
        let program1 = Program(title: "Meditation 101", description: "Techniques, Benefits, and a Beginner’s How-To", image: UIImage(named: "imgMeditation101"), urlString: "https://www.youtube.com/watch?v=85ZM6XPYQpA")
        let program2 = Program(title: "Cardio Meditation", description: "Basics of Yoga for Beginners or Experienced Professionals", image: UIImage(named: "imgCardioMeditation"), urlString: "https://www.youtube.com/watch?v=M75-qW80_6U")
        let program3 = Program(title: "Loving-Kindness Meditation", description: "Loving-kindness meditation is used to strengthen feelings of compassion, kindness, and acceptance toward oneself and others.", image: UIImage(named: "imgLovingKidnessMeditation"), urlString: "https://www.youtube.com/watch?v=aVJdxv9thkA&t=286s")
        let program4 = Program(title: "Transcendental Meditation", description: "This practice is for those who like structure and are serious about maintaining a meditation practice.", image: UIImage(named: "imgTranscendental"), urlString: "https://www.youtube.com/watch?v=ZuoMXHhyMMs")
        let program5 = Program(title: "Mantra meditation", description: "This type of meditation uses a repetitive sound to clear the mind.", image: UIImage(named: "imgMantraMeditation"), urlString: "https://www.youtube.com/watch?v=vbVh43mTHF4 Mantra Meditation")
        
        var programs = [Program]()
        programs += [program1, program2, program3, program4, program5]
        return programs
    }
}


struct SoundConstants {
    static func getSounds() -> [Sound] {
        let sound1 = Sound(title: "Longer Way To Go", image: UIImage(named: "sound1"), countListening: 3, duration: "3:26")
        let sound2 = Sound(title: "Spatium", image: UIImage(named: "sound2"), countListening: 32222, duration: "3:43")
        let sound3 = Sound(title: "Passion", image: UIImage(named: "sound3"), countListening: 3111, duration: "4:13")
        let sound4 = Sound(title: "Beautiful Dreamer", image: UIImage(named: "sound4"), countListening: 355, duration: "0:53")
        let sound5 = Sound(title: "Melancholy Tune", image: UIImage(named: "sound5"), countListening: 35555, duration: "2:51")
        let sound6 = Sound(title: "Tropical Aura", image: UIImage(named: "sound6"), countListening: 3234234, duration: "3:28")
        let sound7 = Sound(title: "Haven of the Faeries", image: UIImage(named: "sound3"), countListening: 34767, duration: "02:34")
        
        var sounds = [Sound]()
        sounds += [sound1, sound2, sound3, sound4, sound5, sound6, sound7]
        return sounds
    }
}
