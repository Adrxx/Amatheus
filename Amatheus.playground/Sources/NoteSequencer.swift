import Foundation

/// It allows you to take an array of `Note`s and transform them into a function that a `ToneGrapher` can use.
public class NoteSequencer {
  private var noteRanges: [Range<Double>] = []
  
  private var maxNoteGap = 0.05
  private var noteGapProportion = 0.2
  /// Controls the overall speed of the notes, 120bpm would mean that a quarter note lasts 0.5 seconds.
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
  
  /// Calculates the overall duration of the note sequence in seconds.
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
  
  /// The function that maps the notes into something a `ToneGrapher` can use.
  ///
  /// - Parameter time: The input time of the simulation.
  /// - Returns: the resulting pitch based on the notes used.
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
