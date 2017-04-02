//: [Previous](@previous)
//: ## Go get 'em Mozart
//: Now that you know the basics, we can go a little bit more complex
import SpriteKit
import AVFoundation

//: A `ToneGrapher` function is of type `(Double) -> Double?`, if you return `nil`, the ToneGrapher will produce no sound.

class GameScene: AmatheusScene {
  

  override func setup() {
    
    let melodySequencer = NoteSequencer(notes: melodyNotes)
    
    let melody = ToneGrapher(mode: .floute)
    
    melody.beatLength = melodySequencer.calculatedLength
    melody.function = { (time) -> Double? in
      return melodySequencer.pitch(atTime: time)
      
    }
    
    self.add(toneGrapher: melody)
    
    let chordsSequencer = NoteSequencer(notes: chordsNotes)
    
    let chords = ToneGrapher(mode: .sax)
    chords.beatLength = chordsSequencer.calculatedLength
    chords.function = { (time) -> Double? in
      return chordsSequencer.pitch(atTime: time)?.shiftedOctave(to: -1)
    }
    self.add(toneGrapher: chords)
  }
  
}

import PlaygroundSupport
let rect = NSRect(x: 0, y: 0, width: 500, height: 600)
let view = SKView(frame: rect)
let scene = GameScene(size: rect.size)
scene.anchorPoint = CGPoint(x: 0.8, y: 0.5)

view.showsFPS = true
view.allowsTransparency = false
view.ignoresSiblingOrder = true
view.isAsynchronous = false
view.presentScene(scene)
PlaygroundPage.current.liveView = view

//: [Next](@next)
