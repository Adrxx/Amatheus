import Foundation
import SpriteKit
import AVFoundation

public typealias ToneGrapherFunction = (_ x:Double) -> Double?

public class ToneGrapher: SKNode {
    
  public var x: Double = 0.0
  public var pointerPositionOverTime: ToneGrapherFunction = { (x) -> Double in return x }
  
  public var upperLimit = 100.0
  public var lowerLimit = -100.0
  public var maxRange = 2.0
  public var pitchMultiplier = 20.0
  
  private let toneGenerator = ToneGenerator()
  private let dotsEmmitter = SKEmitterNode(fileNamed: "dots")!
  private var originalBirthRate: CGFloat = 0.0
  
  public var time: Double = 0.0 {
    willSet {
      let timeCompass = time.truncatingRemainder(dividingBy: self.maxRange)
      if let pointerPosition = self.pointerPositionOverTime(timeCompass) {
        let limitedPointerPosition = min(max(self.lowerLimit,pointerPosition),self.upperLimit)
        self.dotsEmmitter.particlePosition.y = CGFloat(limitedPointerPosition)
        //self.dotsEmmitter.particleBirthRate = self.originalBirthRate
        self.dotsEmmitter.particleAlpha = 1.0
        self.toneGenerator.pitch = self.pitchMultiplier * limitedPointerPosition

      } else {
        self.toneGenerator.pitch = nil
        self.dotsEmmitter.particleAlpha = 0.0

        //self.dotsEmmitter.particleBirthRate = 0.0
      }
    }
  }
  
  public override init() {
    self.originalBirthRate = self.dotsEmmitter.particleBirthRate
    super.init()
    self.addChild(self.dotsEmmitter)
    self.toneGenerator.start()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
}
