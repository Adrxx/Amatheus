import Foundation

extension Double {
  
  public func shiftedOctave(to octave: Int) -> Double {
    return self + (60.0*Double(octave))
  }
  
  public func linear(slope: Double) -> Double {
    return self*slope
  }
  
  public func cosine(amplitude: Double, frequency: Double) -> Double {
    return cos(self*frequency)*amplitude
  }
  
  public func sine(amplitude: Double, frequency: Double) -> Double {
    return sin(self*frequency)*amplitude
  }
  
}

