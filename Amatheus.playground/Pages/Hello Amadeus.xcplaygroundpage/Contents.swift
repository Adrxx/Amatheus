//: [Previous](@previous)

import SpriteKit
import AVFoundation
import GameplayKit

let C = 10.0
let D = 20.0
let E = 30.0
let F = 35.0
let G = 45.0
let A = 55.0
let B = 65.0

class GameScene: SKScene {
  
  let toneGrapher = ToneGrapher()

  var startingTime:CFTimeInterval?

  var amp  = 10.0
  var freq = 10.0
  
  override func sceneDidLoad() {
    self.addChild(self.toneGrapher)


  }

  func mapper(x: Double) -> Double {
    return cos(x*freq)*amp;
  }
  
  override func mouseDown(with event: NSEvent) {

  }
  
  override func keyDown(with event: NSEvent) {

  }
  
  override func update(_ currentTime: TimeInterval) {
    
    
    guard let startingTime = self.startingTime else {
      self.startingTime = currentTime
      return
    }
    let time = currentTime - startingTime
    self.toneGrapher.maxRange = 30
    self.toneGrapher.pointerPositionOverTime = { (x) -> Double? in
      
//      let tone = (floor(x*2)*10)
//      if tone >= 30 && tone < 65 {
//        return tone - 5
//      }
      
      let scale: [Double] = [C,D,E,F,G,A,B,C.octave(1)]
      
      //print(tone)
      return scale[Int(floor(x*3))%scale.count] + x.cosine(amplitude: 2, frequency: 100)
      

//      if tone >= 30 {
//        return tone - 10
//      }
      //return scale[Int(floor(x*5))%6].rawValue
//      switch x {
//      case 0...0.5:
//        return -20
//      case 0.5...1:
//        return -10
//      case 1...1.5:
//        return 0
//      default:
//        return nil
//      }
    }
    self.toneGrapher.time = time
    
  }
}

let rect = NSRect(x: 0, y: 0, width: 400, height: 800)
let view = SKView(frame: rect)
let scene = GameScene(size: rect.size)
view.preferredFramesPerSecond = 60
view.showsFPS = true

//let audioNode = SKAudioNode(fileNamed: "note.mp3")
//audioNode.autoplayLooped = true
//scene.addChild(audioNode)

scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
view.presentScene(scene)

import PlaygroundSupport
PlaygroundPage.current.liveView = view

//: [Next](@next)
