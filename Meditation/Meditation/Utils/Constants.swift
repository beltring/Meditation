//
//  Constants.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 27.09.21.
//

import CodableFirebase
import FirebaseFirestore
import Foundation
import UIKit

struct ProgramConstants {
    static func getPrograms() -> [Program] {
        let program1 = Program(title: "Meditation 101", description: "Techniques, Benefits, and a Beginner’s How-To", image: UIImage(named: "imgMeditation101"), urlString: "https://www.youtube.com/watch?v=85ZM6XPYQpA")
        let program2 = Program(title: "Cardio Meditation", description: "Basics of Yoga for Beginners or Experienced Professionals", image: UIImage(named: "imgCardioMeditation"), urlString: "https://www.youtube.com/watch?v=M75-qW80_6U")
        let program3 = Program(title: "Loving-Kindness Meditation", description: "Loving-kindness meditation is used to strengthen feelings of compassion, kindness, and acceptance toward oneself and others.", image: UIImage(named: "imgLovingKidnessMeditation"), urlString: "https://www.youtube.com/watch?v=aVJdxv9thkA&t=286s")
        let program4 = Program(title: "Transcendental Meditation", description: "This practice is for those who like structure and are serious about maintaining a meditation practice.", image: UIImage(named: "imgTranscendental"), urlString: "https://www.youtube.com/watch?v=ZuoMXHhyMMs")
        let program5 = Program(title: "Mantra meditation", description: "This type of meditation uses a repetitive sound to clear the mind.", image: UIImage(named: "imgMantraMeditation"), urlString: "https://www.youtube.com/watch?v=vbVh43mTHF4")
        
        var programs = [Program]()
        programs += [program1, program2, program3, program4, program5]
        return programs
    }
}


//struct SoundConstants {
//    static func getSounds() -> [Sound] {
//        let sound1 = Sound(title: "Longer Way To Go", imageUrl: "", countListening: 3, duration: "3:26", storageUrl: "")
//        let sound2 = Sound(title: "Spatium", imageUrl: "", countListening: 32222, duration: "3:43", storageUrl: "")
//        let sound3 = Sound(title: "Passion", imageUrl: "", countListening: 3111, duration: "4:13", storageUrl: "")
//        let sound4 = Sound(title: "Beautiful Dreamer", imageUrl: "", countListening: 355, duration: "0:53", storageUrl: "")
//        let sound5 = Sound(title: "Melancholy Tune", imageUrl: "", countListening: 35555, duration: "2:51", storageUrl: "")
//        let sound6 = Sound(title: "Tropical Aura", imageUrl: "", countListening: 3234234, duration: "3:28", storageUrl: "")
//        let sound7 = Sound(title: "Haven of the Faeries", imageUrl: "", countListening: 34767, duration: "02:34", storageUrl: "")
//        let sound8 = Sound(title: "Haven of the Faeries", imageUrl: "", countListening: 34767, duration: "02:34", storageUrl: "")
//        let sound9 = Sound(title: "Haven of the Faeries", imageUrl: "", countListening: 34767, duration: "02:34", storageUrl: "")
//        let sound10 = Sound(title: "Haven of the Faeries", imageUrl: "", countListening: 34767, duration: "02:34", storageUrl: "")
//        let sound11 = Sound(title: "Haven of the Faeries", imageUrl: "", countListening: 34767, duration: "02:34", storageUrl: "")
//        
//        var sounds = [Sound]()
//        sounds += [sound1, sound2, sound3, sound4, sound5, sound6, sound7, sound8, sound9, sound10, sound11]
//        let meditation = Meditation(type: .relax, sounds: sounds)
//        return sounds
//    }
//}
