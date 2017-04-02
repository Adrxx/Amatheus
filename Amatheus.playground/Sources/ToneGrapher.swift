import Foundation
import SpriteKit
import AVFoundation

/// A function that takes a `Double` representing eleapsed seconds and returns another `Double` representing pitch, or nil representing no sound.
public typealias ToneGrapherFunction = (Double) -> Double?

/// A SKNode that graphs and emmits the sound of a certain mathematical function.
public class ToneGrapher: SKNode {
  
  /// The sound and looks of the `ToneGrapher`
  ///
  /// - floute: kind of a soft sound.
  /// - synth: kind of a techno sound.
  /// - sax: kind of a sexy sound.
  public enum Mode : String {
    case floute
    case synth
    case sax
    
    var particleEmmiter: SKEmitterNode {
      return SKEmitterNode(fileNamed: self.rawValue)!
    }
    
    var pitchShifter: PitchShifter {
      let url = Bundle.main.url(forResource:self.rawValue, withExtension: "m4a")!
      let audioFile = try! AVAudioFile(forReading: url)
      return PitchShifter(audioFile: audioFile)
    }
  }
  /// The function used by the `ToneGrapher` to map the inputs to outputs
  public var function: ToneGrapherFunction = { (x) -> Double in return x }
  
  /// The time in seconds until the ToneGrapher loops. 
  public var loopLenght = 60.0
  
  public var volume: Float {
    set {
      self.pitchShifter.volume = newValue
    }
    get {
      return self.pitchShifter.volume
    }
  }

  
  /// The top limit of the graph and pitch.
  public let upperLimit = 120.0
  /// The bottom limit of the graph and pitch.
  public let lowerLimit = -120.0
  
  private let pitchShifter: PitchShifter
  private let particleEmitter: SKEmitterNode
  private let pitchMultiplier = 20.0
  private var skipFrame = false // used to skip a frame so particle emmiter doesn't render itself moving to the new location

  /// the time of the simulation
  public var time: Double = 0.0 {
    willSet {
      let beatLenght = newValue.truncatingRemainder(dividingBy: self.loopLenght)
      
      if let pointerPosition = self.function(beatLenght) {
        let limitedPointerPosition = min(max(self.lowerLimit,pointerPosition),self.upperLimit)
        self.particleEmitter.particlePosition.y = CGFloat(limitedPointerPosition*2)
        self.pitchShifter.pitch = self.pitchMultiplier * limitedPointerPosition
        self.pitchShifter.muted = false
        if skipFrame {
          self.particleEmitter.particleAlpha = 1.0
          skipFrame = false
        } else {
          skipFrame = true
        }
      } else {
        skipFrame = false
        self.pitchShifter.muted = true
        self.particleEmitter.particleAlpha = 0.0
      }
    }
  }
  
  public init(mode: Mode = .floute) {
    self.pitchShifter = mode.pitchShifter
    self.particleEmitter = mode.particleEmmiter
    self.particleEmitter.particleAlpha = 0.0
    super.init()
  }
  
  /// Kickstarts the grapher
  public func start() {
    self.addChild(self.particleEmitter)
    self.pitchShifter.start()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Not Implemented (or needed in this case)")
  }
  
  
}
