import Foundation

extension Double {
  
  /// Shifts the value of a double by the number of octaves specified.
  ///
  /// - Parameter octave: the number of octaves the value will be shifted.
  /// - Returns: The desired shifted value.
  public func shiftedOctave(to octave: Int) -> Double {
    return self + (60.0*Double(octave))
  }
  
  /// A linear function.
  ///
  /// - Parameter slope: the slope or inclination  of the linear function, you can also call it the rate of change.
  /// - Returns: The output value of the linear function 😝.
  public func linear(slope: Double) -> Double {
    return self*slope
  }
  
  /// A cosine function, it always starts at the value +amplitude.
  ///
  /// - Parameters:
  ///   - amplitude: defines how high and low the function can go.
  ///   - frequency: the frequency in which the function repeats its cycle.
  /// - Returns: A value between the range +amplitude and -amplitude.
  public func cosine(amplitude: Double, frequency: Double) -> Double {
    return cos(self*frequency)*amplitude
  }
  
  /// A sine function, it always starts at 0.
  ///
  /// - Parameters:
  ///   - amplitude: defines how high and low the function can go.
  ///   - frequency: the frequency in which the function repeats its cycle
  /// - Returns: A value between the range +amplitude and -amplitude.
  public func sine(amplitude: Double, frequency: Double) -> Double {
    return sin(self*frequency)*amplitude
  }
  
}

