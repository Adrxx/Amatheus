import Foundation
import SpriteKit

open class Amatheus: SKScene {
  
  private let initialDelay = 1.0
  private let background = SKSpriteNode(imageNamed: "background")
  private let sparks = SKEmitterNode(fileNamed: "stars")!

  open var toneGraphers: [ToneGrapher] = []
  var startingTime: CFTimeInterval?
  var now: CFTimeInterval?
  
  open override func didMove(to view: SKView) {
    self.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2862745098, blue: 0.3098039216, alpha: 1)
    self.anchorPoint = CGPoint(x: 0.8, y: 0.5)
    
    self.background.position.x -= 200
    self.addChild(self.background)
    self.sparks.alpha = 0.0
    self.sparks.position.x += 200
    self.sparks.advanceSimulationTime(20)
    self.addChild(self.sparks)
    
    self.sparks.run(SKAction.fadeIn(withDuration: self.initialDelay*3))
    self.setup()
  }
  
  open func add(toneGrapher: ToneGrapher) {
    self.addChild(toneGrapher)
    self.toneGraphers.append(toneGrapher)
    toneGrapher.start()
  }
  
  open func setup() {}
  
  override open func didFinishUpdate() {
    if let now = self.now {
      for toneGrapher in self.toneGraphers {
        let delayedNow = now - self.initialDelay
        if delayedNow > 0 {
          toneGrapher.time = delayedNow
        }
      }
    }
  }

  
  override open func update(_ currentTime: TimeInterval) {
    if let startingTime = self.startingTime {
      self.now = (currentTime - startingTime)
    } else {
      self.startingTime = currentTime
    }
  }
  
  
}
