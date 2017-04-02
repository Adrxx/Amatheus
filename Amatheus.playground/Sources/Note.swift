/// A struct representation of a note that you can use to create melodies with the use of the `NoteSequencer` class.
public struct Note {
  
  /// An enum that defines values for all the notes in the major scale.
  ///
  /// - C: Do, has a value of 0
  /// - D: Re, has a value of 10
  /// - E: Mi, has a value of 20
  /// - F: Fa, has a value of 25
  /// - G: Sol, has a value of 35
  /// - A: La, has a value of 45
  /// - B: Ti, has a value of 55
  public enum Name: Double {
    case C = 0.0 // Do
    case D = 10.0 // Re
    case E = 20.0 // Mi
    case F = 25.0 // Fa
    case G = 35.0 // Sol
    case A = 45.0 // La
    case B = 55.0 // Ti
  }
  
  /// An enum that defines the length of the note.
  ///
  /// - doubleWhole: Breve
  /// - whole: Semibreve
  /// - half: Minim
  /// - quarter: Crotchet
  /// - eighth: Quaver
  /// - sixteenth: Semiquaver
  /// - thirtySecond: Demisemiquaver
  /// - sixtyFourth: Hemidemisemiquaver
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
  
  /// The pitch of the note expressed as a number.
  public private(set) var pitch: Double?
  /// The length of the note expressed as a number, its actual length depends on how it is mapped through a `NoteSequencer`'s `beatsPerMinute`.
  public private(set) var length: Double
  
  /// Returns the 'sharp' version of the note that called it, which ultimately means add 5 to the note's pitch.
  public var sharp: Note {
    return Note(pitch: self.pitch?.advanced(by: 5), length: self.length)
  }
  
  /// Returns the 'flat' version of the note that called it, which ultimately means substract 5 to the note's pitch.
  public var flat: Note {
    return Note(pitch: self.pitch?.advanced(by: -5), length: self.length)
  }
  /// Returns the 'dotted' version of the note that called it, which ultimately means add half of the note's length to itself.
  public var dotted: Note {
    return Note(pitch: self.pitch, length: self.length + 0.5*self.length)
  }
  
  /// Adds extra lenght for complex note durations
  ///
  /// - Parameter length: the length to add
  /// - Returns: the same note with the length added as specified.
  public func extra(length: Length) -> Note {
    return Note(pitch: self.pitch, length: self.length+length.rawValue)
  }
  
  /// Shifts a note to a octave.
  ///
  /// - Parameter octave: The number of octaves that the note will be shifted.
  /// - Returns: the same note with the octave shifted as specified.
  public func octave(_ octave: Int) -> Note {
    return Note(pitch: self.pitch?.advanced(by: (60.0*Double(octave))), length: self.length)
  }
  
  /// Creates a note by specifying raw `Double` values.
  ///
  /// - Parameters:
  ///   - pitch: numeric value of the pitch.
  ///   - length: numeric value of the length, its actual length depends on how it is mapped through a `NoteSequencer`'s `beatsPerMinute` property.
  init(pitch: Double?, length: Double) {
    self.pitch = pitch
    self.length = length
  }
  
  /// Creates a note using the `Note.Name` and `Note.Length` enums.
  ///
  /// - Parameters:
  ///   - name: the name of the note.
  ///   - length: the length of the note, its actual length depends on how it is mapped through a `NoteSequencer`'s `beatsPerMinute` property.
  public init(_ name: Name?, _ length: Length = .quarter) {
    self.pitch = name?.rawValue
    self.length = length.rawValue
  }
}

