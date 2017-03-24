import Foundation
import SpriteKit
import AVFoundation

public typealias ToneGrapherFunction = (_ x:Double) -> Double?
public typealias Seconds = Double
public typealias Note = Double
public let C = 0.0
public let D = 10.0
public let E = 20.0
public let F = 25.0
public let G = 35.0
public let A = 45.0
public let B = 55.0

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
  

  public var beatLenght = 2.0
  
  public let upperLimit = 120.0
  public let lowerLimit = -120.0
  
  private let toneGenerator: ToneGenerator
  private let particleEmitter: SKEmitterNode
  
  private let pitchMultiplier = 20.0

  public var time: Double = 0.0 {
    willSet {
      let beatLenght = time.truncatingRemainder(dividingBy: self.beatLenght)
      if let pointerPosition = self.function(beatLenght) {
        let limitedPointerPosition = min(max(self.lowerLimit,pointerPosition),self.upperLimit)
        self.particleEmitter.particlePosition.y = CGFloat(limitedPointerPosition)
        self.particleEmitter.particleAlpha = 1.0
        self.toneGenerator.pitch = self.pitchMultiplier * limitedPointerPosition

      } else {
        self.particleEmitter.particleAlpha = 0.0
        self.toneGenerator.pitch = nil

      }
    }
  }
  
  public init(mode: Mode = .floute) {
    self.toneGenerator = mode.toneGenerator
    self.particleEmitter = mode.particleEmmiter
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
