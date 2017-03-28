import Foundation
import SpriteKit

open class Amatheus: SKScene {
  
  private let initialDelay = 1.0
  open var toneGraphers: [ToneGrapher] = []
  var startingTime: CFTimeInterval?
  var now: CFTimeInterval?

  open func add(toneGrapher: ToneGrapher) {
    self.addChild(toneGrapher)
    self.toneGraphers.append(toneGrapher)
    toneGrapher.start()
  }
  
  open override func didMove(to view: SKView) {
    self.setup()
  }
  
  open func setup() {}

  
  override open func update(_ currentTime: TimeInterval) {
    if let startingTime = self.startingTime {
      self.now = (currentTime - startingTime)
    } else {
      self.startingTime = currentTime
    }
    if let now = self.now {
      for toneGrapher in self.toneGraphers {
        let delayedNow = now - self.initialDelay
        if delayedNow > 0 {
          toneGrapher.time = delayedNow
        }
      }
    }
  }
  
  
}
