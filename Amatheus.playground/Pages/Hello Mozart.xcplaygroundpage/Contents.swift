//: [Previous](@previous)
//: # A Swift Tour
//:
//: Tradition suggests that the first program in a new language should print the words “Hello, world!” on the screen. In Swift, this can be done in a single line:
//:
import SpriteKit
import AVFoundation

struct Note {
  
  enum Name: Double {
    case C = 0.0 // Do
    case D = 10.0 // Re
    case E = 20.0 // Mi
    case F = 25.0 // Fa
    case G = 35.0 // Sol
    case A = 45.0 // La
    case B = 55.0 // Ti
  }
  
  enum Length: Double {
    case doubleWhole = 8 // Breve
    case whole = 4 // Semibreve
    case half = 2 // Minim
    case quarter = 1 // Crotchet
    case eighth = 0.5 // Quaver
    case sixteenth = 0.25 // Semiquaver
    case thirtySecond = 0.125 // Demisemiquaver
    case sixtyFourth = 0.0625 // Hemidemisemiquaver
    // And so on...
  }
  
  private(set) var pitch: Double?
  private(set) var length: Double
  
  var sharp: Note {
    return Note(pitch: self.pitch?.advanced(by: 5), length: self.length)
  }
  
  var flat: Note {
    return Note(pitch: self.pitch?.advanced(by: -5), length: self.length)
  }
  
  var dotted: Note {
    return Note(pitch: self.pitch, length: self.length + 0.5*self.length)
  }
  
  func octave(_ octave: Int) -> Note {
    return Note(pitch: self.pitch?.advanced(by: (60.0*Double(octave))), length: self.length)
  }
  
  init(pitch: Double?, length: Length = .quarter) {
    self.pitch = pitch
    self.length = length.rawValue
  }
  
  init(_ name: Name?, _ length: Length = .quarter) {
    self.pitch = name?.rawValue
    self.length = length.rawValue
  }

  
}

class NoteSequencer {
  private var noteRanges: [Range<Double>] = []
  
  private var maxNoteGap = 0.05
  var beatsPerMinute = 120.0 {
    didSet {
      self.updateRanges()
    }
  }
  private var notes: [Note] = [] {
    didSet {
      self.updateRanges()
    }
  }

  private var speed: Double {
    get {
      return 60 / self.beatsPerMinute
    }
  }

  var calculatedLength: Double {
    return self.notes.reduce(0.0, { (result, note) -> Double in
      return result + note.length*self.speed
    })
  }
  
  init(notes: [Note]) {
    self.notes = notes
    self.updateRanges()
  }
  
  private func updateRanges() {
    self.noteRanges = []
    var accumulatedLength = 0.0
    for note in self.notes {
      let length = note.length * self.speed
      let gap = min(0.12 * length,self.maxNoteGap)
      let noteRange = accumulatedLength..<accumulatedLength + length - gap
      accumulatedLength += length
      self.noteRanges.append(noteRange)
    }
  }
  
  func pitch(atTime time: Double) -> Double? {
    
    guard let currentRange = currentRange else {
      for (i,range) in self.noteRanges.enumerated() {
        if range.contains(time) {
          self.currentRange = range
          return self.notes[i].pitch
        }
      }
      return nil
    }
    
    return self.notes[].pitch
    
    var i = 0 // Good old index because this will be executed a lot, enumerated() wouldn't be the best
    for range in self.noteRanges {
      if range.contains(time) {
        return self.notes[i].pitch
      }
      i+=1
    }
    return nil
  }
  
}


class GameScene: Amatheus {
  
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
