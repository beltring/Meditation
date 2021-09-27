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
