//: [Previous](@previous)
//: ## Go get 'em Mozart
//: Now that you know the basics, we can go a dive little bit deeper and go a little bit more complex. If you return a constant 0 in the function of a `ToneGrapher` you would get a C (Do), +5 is a semitone up and so +10 is a one tone up. So a 10 is equal to R (Re), and 15 is equal to R# (Re sharp). With this info, you can start building your masterpieces.

class SmokeInTheWaterScene: AmatheusScene {
//: I made this mini API to make songs. Let's write some notes.
  let smokeInTheWater: [Note] = [
    Note(.G, .eighth),
    Note(nil, .eighth),
    Note(.B, .eighth).flat,
    Note(nil, .eighth),
    Note(.C ).octave(1),
    Note(nil, .eighth),
    Note(.G, .eighth),
    Note(nil, .eighth),
    Note(.B, .eighth).flat,
    Note(nil, .eighth),
    Note(.D, .eighth).octave(1).flat,
    Note(.C, .half).octave(1),
    Note(.G, .eighth),
    Note(nil, .eighth),
    Note(.B, .eighth).flat,
    Note(nil, .eighth),
    Note(.C ).octave(1),
    Note(nil, .eighth),
    Note(.B, .eighth).flat,
    Note(nil, .eighth),
    Note(.G, .half).dotted.extra(length: .eighth),
    ]
//: A note can also be written like this `Note(.G)`, if you don't define its length, the default is a quarter note. Notice how you can also make flat or sharp variations and even dotted notes.
  let smokeInTheWaterSecondVoice: [Note] = [
    Note(.D, .eighth),
    Note(nil, .eighth),
    Note(.F, .eighth),
    Note(nil, .eighth),
    Note(.G ),
    Note(nil, .eighth),
    Note(.D, .eighth),
    Note(nil, .eighth),
    Note(.F, .eighth),
    Note(nil, .eighth),
    Note(.A, .eighth).flat,
    Note(.G, .half),
    Note(.D, .eighth),
    Note(nil, .eighth),
    Note(.F, .eighth),
    Note(nil, .eighth),
    Note(.G ),
    Note(nil, .eighth),
    Note(.F, .eighth),
    Note(nil, .eighth),
    Note(.D, .half).dotted.extra(length: .eighth),
    ]
  
  override func setup() {
//:  Here we'll use a `NoteSequencer` class, which you can use to arrange some Notes and generate a meoldic function for the `ToneGrapher`.
    let chordsSequencer = NoteSequencer(notes: smokeInTheWaterSecondVoice)
    let lowVoice = ToneGrapher(mode: .sax)
    lowVoice.loopLenght = chordsSequencer.calculatedLength
    // You can also set the function directly...
    lowVoice.function = chordsSequencer.pitch(atTime:)
    self.add(toneGrapher: lowVoice)
    
    let melodySequencer = NoteSequencer(notes: smokeInTheWater)
    let highVoice = ToneGrapher(mode: .sax)
//: A `ToneGrapher` function is of type `(Double) -> Double?`, if you return `nil`, the ToneGrapher will produce no sound. That's why some notes above are `nil`, they are rests.
    highVoice.loopLenght = melodySequencer.calculatedLength
    highVoice.function = { (time) -> Double? in
      return melodySequencer.pitch(atTime: time)?.advanced(by: 0)
    }
    
    self.add(toneGrapher: highVoice)
    
//: - Experiment:
//: Change some of the notes above, maybe mess with the highVoice function by changing the 0 in advanced(by: 0)
    
//: Here are other songs you can check out:
//:
//: [Ode To Joy](OdeToJoy) | [Stand By Me](StandByMe)
    
//: And when you're done, it's time to go [Crazy](Crazy)!
  }
}

import PlaygroundSupport
import SpriteKit
let rect = NSRect(x: 0, y: 0, width: 500, height: 600)
let view = SKView(frame: rect)
let scene = SmokeInTheWaterScene(size: rect.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view