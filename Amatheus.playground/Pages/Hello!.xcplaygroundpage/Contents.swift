//: # A(math)eus 🎷
//:
//: A(math)eus is an Audiovisual Grapher built with Sprite Kit, AVFoundation and ❤️. This playground came to life with the idea of not only seeing but also listen to the different mathematical using the eleapsed time in seconds as the input and the tone pitch as the output. As I was building the project, I discovered lots of cool stuff you can do with it, and so I wrote my code in a way you can you can experiment with it.

import SpriteKit

class WelcomeScene: Amatheus {
  
  override func setup() {
    
    let sineTone = ToneGrapher(mode: .floute)
    sineTone.beatLength = Double.pi*2
    
    let classicSine: (Double) -> Double? = { (time) -> Double? in
      return time.sine(amplitude: 50, frequency: 1)
    }
    
    let sineception: (Double) -> Double? = { (time) -> Double? in
      return time.sine(amplitude: 50, frequency: 1) + time.sine(amplitude: 5, frequency: 10)
    }
//: - Experiment:
//: This is where you
    sineTone.function = sineception
    self.add(toneGrapher: sineTone)
    
  }
  
}


import PlaygroundSupport
let rect = NSRect(x: 0, y: 0, width: 500, height: 600)
let view = SKView(frame: rect)
let scene = WelcomeScene(size: rect.size)

view.presentScene(scene)
PlaygroundPage.current.liveView = view