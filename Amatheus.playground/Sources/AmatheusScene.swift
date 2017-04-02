import Foundation
import SpriteKit

/// An Amatheus scene that allows you to use `ToneGrapher`s
open class AmatheusScene: SKScene {
  
  /// The initial delay before the any of the tone graphers starts playing
  public let initialDelay = 1.0

  private let background = SKSpriteNode(imageNamed: "background")
  private let stars = SKEmitterNode(fileNamed: "stars")!

  open var toneGraphers: [ToneGrapher] = []
  private var startingTime: CFTimeInterval?
  private var now: CFTimeInterval?
  
  open override func didMove(to view: SKView) {
    self.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2862745098, blue: 0.3098039216, alpha: 1)
    self.anchorPoint = CGPoint(x: 0.8, y: 0.5)
    self.background.position.x -= 200
    self.addChild(self.background)
    self.stars.alpha = 0.0
    self.stars.position.x += 200
    self.stars.advanceSimulationTime(20)
    self.addChild(self.stars)
    self.stars.run(SKAction.fadeIn(withDuration: self.initialDelay*3))
    self.setup()
  }
  
  /// Adds a `ToneGrapher` to the scene.
  ///
  /// - Parameter toneGrapher: the `ToneGrapher` to add.
  open func add(toneGrapher: ToneGrapher) {
    self.addChild(toneGrapher)
    self.toneGraphers.append(toneGrapher)
    toneGrapher.start()
  }
  
  /// Use this function to setup any tone graphers before the simulation stars.
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
