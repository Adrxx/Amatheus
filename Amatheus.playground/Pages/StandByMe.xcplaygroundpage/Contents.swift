//: [Back](Musical)
//: ## Stand By Me
//: By Jerry Leiber
class StandByMe: AmatheusScene {
  let melodyNotes: [Note] = [
    Note(nil, .whole),
    Note(nil, .whole),
    Note(nil, .whole),
    Note(nil, .whole),
    Note(nil, .whole),
    Note(nil, .whole),
    Note(nil, .whole),
    Note(nil, .half),
    Note(nil, .eighth),
    Note(.A, .eighth),
    Note(.C, .eighth).octave(1),
    Note(.D).octave(1),
    Note(nil, .half),
    Note(nil, .eighth),
    Note(.A, .eighth),
    Note(.C, .half).octave(1),
    Note(nil),
    Note(nil, .half),
    Note(nil, .eighth),
    Note(.F, .eighth),
    Note(.G, .eighth),
    Note(.A, .eighth),
    Note(.A, .eighth),
    Note(.G ),
    Note(.F ),
    Note(nil),
    Note(nil),
    Note(.F, .eighth),
    Note(.G, .eighth),
    Note(.A, .eighth),
    Note(.F ).dotted,
    Note(nil),
    Note(.F, .eighth),
    Note(.A, .eighth),
    Note(.A, .eighth),
    Note(.G),
    Note(.G, .eighth),
    Note(nil, .eighth),
    Note(.F, .eighth),
    Note(.G),
    Note(.F),
    Note(nil, .eighth),
    Note(nil),
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
    Note(.C ),
    Note(.D ),
    Note(nil, .eighth),
    Note(.D ).dotted,
    Note(.D, .eighth),
    Note(.C, .eighth),
    Note(.B ).flat.octave(-1),
    Note(nil, .eighth),
    Note(.B ).dotted.flat.octave(-1),
    Note(.B, .eighth).flat.octave(-1),
    Note(.D , .eighth),
    Note(.C),
    Note(nil, .eighth),
    Note(.C).dotted,
    Note(.C, .eighth),
    Note(.E, .eighth),
    Note(.F ),
    Note(nil, .eighth),
    Note(.F ).dotted,
    Note(.C, .eighth),
    Note(.E, .eighth),
    Note(.F ),
    Note(nil, .eighth),
    Note(.F ).dotted,
    Note(nil),
    ]
  
  override func setup() {
    
    let melodySequencer = NoteSequencer(notes: melodyNotes)
    let melody = ToneGrapher(mode: .floute)
    melody.loopLenght = melodySequencer.calculatedLength
    melody.function = melodySequencer.pitch(atTime:)
    self.add(toneGrapher: melody)
    
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
