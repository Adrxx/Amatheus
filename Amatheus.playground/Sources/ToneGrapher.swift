import Foundation
import SpriteKit
import AVFoundation

public typealias ToneGrapherFunction = (Double) -> Double?

public class ToneGrapher: SKNode {
  
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
  
  public var x: Double = 0.0
  public var function: ToneGrapherFunction = { (x) -> Double in return x }
  
  public var beatLength = 60.0
  
  public let upperLimit = 120.0
  public let lowerLimit = -120.0
  
  private let pitchShifter: PitchShifter
  private let particleEmitter: SKEmitterNode
  
  private let pitchMultiplier = 20.0
  private var skipFrame = false // used to skip a frame so particle emmiter doesn't render itself moving to the new location

  public var time: Double = 0.0 {
    willSet {
      let beatLenght = newValue.truncatingRemainder(dividingBy: self.beatLength)
      
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
  
  public func start() {
    self.addChild(self.particleEmitter)
    self.pitchShifter.start()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Not Implemented (or needed in this case)")
  }
  
  
}
