//: # A(math)eus 🎷
//: A(math)eus is an Audiovisual Grapher built with Sprite Kit, AVFoundation and ❤️.
//: ## Let's walk you through the basics
//: A mathematical function relates inputs with ouputs, for this project, the input will be the eleapsed seconds of the scene and the ouput will be the pitch of a sound. Use the `ToneGrapher` class to specify the function that you want and then add it to your `AmatheusScene` in the `setup()` method.
class WelcomeScene: AmatheusScene {

  override func setup() {
//: - Experiment:
//: Try changing the `toneGrapher` function to any of the three functions I've made below. Mess with its other properties, if you're unsure of what they do, click on them while holding the **⌥ Opt** key.
    let toneGrapher = ToneGrapher(mode: .floute)
    toneGrapher.loopLenght = Double.pi*2
//: I've extended Double class with some helper functions like sine, cosine and linear. Here's a function you can use...
    let sine: (Double) -> Double? = { (time) -> Double? in
      return time.sine(amplitude: 50, frequency: 1)
    }
//: Another function you can use...
    let sineJumps: (Double) -> Double? = { (time) -> Double? in
      let s = time.sine(amplitude: 10, frequency: 5)
      return s > 0 ? s : nil
    }
//: And the function you started with...
    let sineception: (Double) -> Double? = { (time) -> Double? in
      return time.sine(amplitude: 50, frequency: 1) + time.sine(amplitude: 5, frequency: 10)
    }
//: Change the function here:
    toneGrapher.function = sineception
    
    self.add(toneGrapher: toneGrapher)
    
//: You can have multiple Tone Graphers:
    
    let otherToneGrapher = ToneGrapher(mode: .sax)
    otherToneGrapher.loopLenght = Double.pi*4
    otherToneGrapher.function = { (time) -> Double? in
      return sineJumps(time)?.advanced(by: -20)
    }
    self.add(toneGrapher: otherToneGrapher)
 
    
  }
}

//: Are yo ready to get [Musical](Musical)?
import PlaygroundSupport
import SpriteKit
let rect = NSRect(x: 0, y: 0, width: 500, height: 600)
let view = SKView(frame: rect)
let scene = WelcomeScene(size: rect.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view