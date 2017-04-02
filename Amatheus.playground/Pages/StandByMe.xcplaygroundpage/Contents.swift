//: [Back](@Musical)
//: ## Stand By Me
//: By Beethoven

class StandByMe: AmatheusScene {
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
    Note(.F ),
    Note(nil, .eighth),
    Note(.F ).dotted,
    Note(.C, .eighth),
    Note(.E, .eighth),
    Note(.F ),
    Note(nil, .eighth),
    Note(.F ).dotted,
    Note(.F, .eighth),
    Note(.E, .eighth),
    Note(.D ),
    Note(nil, .eighth),
    Note(.D ).dotted,

    ]
  
  override func setup() {
    
    let melodySequencer = NoteSequencer(notes: melodyNotes)
    let melody = ToneGrapher(mode: .floute)
    melody.loopLenght = melodySequencer.calculatedLength
    melody.function = melodySequencer.pitch(atTime:)
    //self.add(toneGrapher: melody)
    
    let chordsSequencer = NoteSequencer(notes: chordsNotes)
    let chords = ToneGrapher(mode: .sax)
    chords.loopLenght = chordsSequencer.calculatedLength
    chords.function = { (time) -> Double? in
      return chordsSequencer.pitch(atTime: time)
    }
    self.add(toneGrapher: chords)
    
  }
}

import PlaygroundSupport
import SpriteKit
let rect = NSRect(x: 0, y: 0, width: 500, height: 600)
let view = SKView(frame: rect)
let scene = StandByMe(size: rect.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view
