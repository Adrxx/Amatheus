import Foundation

extension Double {
  
  public func shiftedOctave(to octave: Int) -> Double {
    return self + (60.0*Double(octave))
  }
  
  public func square(slope: Double) -> Double {
    return self
  }
  
  public func linear(slope: Double) -> Double {
    return self
  }
  
  public func cosine(amplitude: Double, frequency: Double) -> Double {
    return cos(self*frequency)*amplitude
  }
  
  public func sine(amplitude: Double, frequency: Double) -> Double {
    return sin(self*frequency)*amplitude
  }
  
  public func tangent(amplitude: Double, frequency: Double) -> Double {
    return self
  }
}




//public enum Note: Double {
//  let C = 10
//  let D = 20
//  let E = 30
//  let F = 35
//  let G = 45
//  let A = 55
//  let B = 65
//  
//  public func sharp() -> Double {
//    return self.rawValue + 5.0
//  }
//}
