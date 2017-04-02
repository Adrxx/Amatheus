import Foundation


public class NoteSequencer {
  private var noteRanges: [Range<Double>] = []
  
  private var maxNoteGap = 0.05
  private var noteGapProportion = 0.15
  public var beatsPerMinute = 120.0 {
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
  
  public var calculatedLength: Double {
    return self.notes.reduce(0.0, { (result, note) -> Double in
      return result + note.length*self.speed
    })
  }
  
  public init(notes: [Note]) {
    self.notes = notes
    self.updateRanges()
  }
  
  private func updateRanges() {
    self.noteRanges = []
    var accumulatedLength = 0.0
    for note in self.notes {
      let length = note.length * self.speed
      let gap = min(self.noteGapProportion * length,self.maxNoteGap)
      let noteRange = accumulatedLength..<accumulatedLength + length - gap
      accumulatedLength += length
      self.noteRanges.append(noteRange)
    }
  }
  
  public func pitch(atTime time: Double) -> Double? {
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
