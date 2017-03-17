//: [Previous](@previous)

import SpriteKit
import AVFoundation

class GameScene: Amatheus {
  
  override func setup() {
    let tone1 = ToneGrapher()
    tone1.beatLenght = M_PI_2
    tone1.function = { (x) -> Double in
      return x.sine(amplitude: 100, frequency: 10)
    }
    self.add(toneGrapher: tone1)
    
    let tone2 = ToneGrapher()
    tone2.beatLenght = M_PI
    tone2.function = { (x) -> Double in
      return C
    }
    self.add(toneGrapher: tone2)


  }
}

import PlaygroundSupport
let rect = NSRect(x: 0, y: 0, width: 400, height: 300)
let view = SKView(frame: rect)
let scene = GameScene(size: rect.size)
view.preferredFramesPerSecond = 60
view.showsFPS = true

scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
view.presentScene(scene)

PlaygroundPage.current.liveView = view

//: [Next](@next)
