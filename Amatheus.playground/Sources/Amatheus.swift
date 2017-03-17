import Foundation
import SpriteKit

open class Amatheus: SKScene {
  open var toneGraphers: [ToneGrapher] = []
  var startingTime:CFTimeInterval?
  
  open func add(toneGrapher: ToneGrapher) {
    self.addChild(toneGrapher)
    toneGrapher.start()
    self.toneGraphers.append(toneGrapher)
  }
  
  open override func didMove(to view: SKView) {
    self.setup()
  }
  
  open func setup() {}
  
  override open func update(_ currentTime: TimeInterval) {
    if let startingTime = self.startingTime {
      let now = (startingTime - currentTime)
      for toneGrapher in self.toneGraphers {
        toneGrapher.time = now
      }
    } else {
      self.startingTime = currentTime
    }
  }
}
