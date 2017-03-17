import Foundation
import SpriteKit
import AVFoundation

public typealias ToneGrapherFunction = (_ x:Double) -> Double?
public typealias Seconds = Double
public typealias Note = Double
public let C = 10.0
public let D = 20.0
public let E = 30.0
public let F = 35.0
public let G = 45.0
public let A = 55.0
public let B = 65.0

public class ToneGrapher: SKNode {
    
  public var x: Double = 0.0
  public var function: ToneGrapherFunction = { (x) -> Double in return x }
  

  public var beatLenght = 2.0
  
  public let upperLimit = 120.0
  public let lowerLimit = -120.0
  
  private let toneGenerator = ToneGenerator()
  private let dotsEmmitter = SKEmitterNode(fileNamed: "dots")!
  private let pitchMultiplier = 20.0

  public var time: Double = 0.0 {
    willSet {
      let beatLenght = time.truncatingRemainder(dividingBy: self.beatLenght)
      if let pointerPosition = self.function(beatLenght) {
        let limitedPointerPosition = min(max(self.lowerLimit,pointerPosition),self.upperLimit)
        self.dotsEmmitter.particlePosition.y = CGFloat(limitedPointerPosition)
        self.dotsEmmitter.particleAlpha = 1.0
        self.toneGenerator.pitch = self.pitchMultiplier * limitedPointerPosition

      } else {
        self.dotsEmmitter.particleAlpha = 0.0
        self.toneGenerator.pitch = nil

      }
    }
  }
  
  public override init() {
    super.init()
  }
  
  public func start() {
    self.addChild(self.dotsEmmitter)
    self.toneGenerator.start()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
}
