public struct Note {
  
  public enum Name: Double {
    case C = 0.0 // Do
    case D = 10.0 // Re
    case E = 20.0 // Mi
    case F = 25.0 // Fa
    case G = 35.0 // Sol
    case A = 45.0 // La
    case B = 55.0 // Ti
  }
  
  public enum Length: Double {
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
  
  public private(set) var pitch: Double?
  public private(set) var length: Double
  
  public var sharp: Note {
    return Note(pitch: self.pitch?.advanced(by: 5), length: self.length)
  }
  
  public var flat: Note {
    return Note(pitch: self.pitch?.advanced(by: -5), length: self.length)
  }
  
  public var dotted: Note {
    return Note(pitch: self.pitch, length: self.length + 0.5*self.length)
  }
  
  public func octave(_ octave: Int) -> Note {
    return Note(pitch: self.pitch?.advanced(by: (60.0*Double(octave))), length: self.length)
  }
  
  init(pitch: Double?, length: Double) {
    self.pitch = pitch
    self.length = length
  }
  
  public init(_ name: Name?, _ length: Length = .quarter) {
    self.pitch = name?.rawValue
    self.length = length.rawValue
  }
}

