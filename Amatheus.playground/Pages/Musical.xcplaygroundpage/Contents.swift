//: [Previous](@previous)
//: # A Swift Tour
//:
//: Tradition suggests that the first program in a new language should print the words “Hello, world!” on the screen. In Swift, this can be done in a single line:
//:
import SpriteKit
import AVFoundation

//: A `ToneGrapher` function is of type `(Double) -> Double?`, if you return `nil`, the ToneGrapher will produce no sound.

class GameScene: AmatheusScene {
  
  let melodyNotes: [Note] = [
    Note(.E),
    Note(.E),
    Note(.F),
    Note(.G),
    Note(.G),
    Note(.F),
    Note(.E),
    Note(.D),
    Note(.C),
    Note(.C),
    Note(.D),
    Note(.E),
    Note(.E).dotted,
    Note(.D , .eighth),
    Note(.D , .half),
    Note(.E),
    Note(.E),
    Note(.F),
    Note(.G),
    Note(.G),
    Note(.F),
    Note(.E),
    Note(.D),
    Note(.C),
    Note(.C),
    Note(.D),
    Note(.E),
    Note(.D).dotted,
    Note(.C , .eighth),
    Note(.C , .half),
    Note(.D),
    Note(.D),
    Note(.E),
    Note(.C),
    Note(.D),
    Note(.E , .eighth),
    Note(.F , .eighth),
    Note(.E),
    Note(.C),
    Note(.D),
    Note(.E , .eighth),
    Note(.F , .eighth),
    Note(.E),
    Note(.D),
    Note(.C),
    Note(.D),
    Note(nil , .half),
    Note(.E),
    Note(.E),
    Note(.F),
    Note(.G),
    Note(.G),
    Note(.F),
    Note(.E),
    Note(.D),
    Note(.C),
    Note(.C),
    Note(.D),
    Note(.E),
    Note(.D).dotted,
    Note(.C , .eighth),
    Note(.C , .half),
    ]
  
  let chordsNotes: [Note] = [
    Note(.C , .whole),
    Note(.G , .whole),
    Note(.E , .whole),
    Note(.G , .whole),
    Note(.C , .whole),
    Note(.G , .whole),
    Note(.E , .whole),
    Note(.F , .half),
    Note(.E , .half),
    Note(.G , .whole).octave(1),
    Note(.G , .whole).octave(1),
    Note(.G , .half).octave(1),
    Note(.G , .half).sharp.octave(1),
    Note(.A , .half).octave(1),
    Note(.G , .half).octave(1),
    Note(.C , .whole),
    Note(.G , .whole),
    Note(.E , .whole),
    Note(.F , .half),
    Note(.E , .half),
    ]
  
  override func setup() {
    
    
    
    let notes3: [Note] = [
      Note(.G, .thirtySecond),
      Note(.A, .sixtyFourth).sharp,
      Note(.C , .sixtyFourth).octave(1),
      Note(.G , .sixtyFourth),
      Note(.A , .sixtyFourth).sharp,
      Note(.C , .sixtyFourth).sharp.octave(1),
      Note(.C , .eighth).octave(1),
      Note(.G , .sixtyFourth),
      Note(.A , .sixtyFourth).sharp,
      Note(.C , .sixtyFourth).octave(1),
      Note(.A , .sixtyFourth).sharp,
      Note(.G , .sixtyFourth),
      ]
    
    
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
