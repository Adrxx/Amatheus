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
    
    var toneGenerator: ToneGenerator {
      let url = Bundle.main.url(forResource:self.rawValue, withExtension: "m4a")!
      let audioFile = try! AVAudioFile(forReading: url)
      return ToneGenerator(audioFile: audioFile)
    }
  }
  
  public var x: Double = 0.0
  public var function: ToneGrapherFunction = { (x) -> Double in return x }
  

  public var beatLength = 2.0
  
  public let upperLimit = 120.0
  public let lowerLimit = -120.0
  
  private let toneGenerator: ToneGenerator
  private let particleEmitter: SKEmitterNode
  
  private let pitchMultiplier = 20.0
  private var flag = 0

  public var time: Double = 0.0 {
    willSet {
      let beatLenght = newValue.truncatingRemainder(dividingBy: self.beatLength)
      
      if let pointerPosition = self.function(beatLenght) {
        let limitedPointerPosition = min(max(self.lowerLimit,pointerPosition),self.upperLimit)
        self.particleEmitter.particlePosition.y = CGFloat(limitedPointerPosition*2)
        self.toneGenerator.pitch = self.pitchMultiplier * limitedPointerPosition
        self.toneGenerator.muted = false
        if flag > 0 {
          self.particleEmitter.particleAlpha = 1.0
          flag = 0
        } else {
          flag += 1
        }
      } else {
        flag = 0
        self.toneGenerator.muted = true
        self.particleEmitter.particleAlpha = 0.0
      }
    }
    
    didSet {
      
    }
  }
  
  public init(mode: Mode = .floute) {
    self.toneGenerator = mode.toneGenerator
    self.particleEmitter = mode.particleEmmiter
    self.particleEmitter.particleAlpha = 0.0
    super.init()
  }
  
  public func start() {
    self.addChild(self.particleEmitter)
    self.toneGenerator.start()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Not Implemented (or needed in this case)")
  }
  
  
}
