//: [Previous](@previous)
//: ## Get Crazy
//: Now mix all of what you've learned and experiment!
class GetCrazy: AmatheusScene {
//: 🎶La cucaracha! La cucaracha! Ya no puede caminar, porque no tiene, porque le falta, una pata de atrás.🎶 Keep scrolling...
  let cucaracha: [Note] = [
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.F).dotted,
    Note(.A),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.F).dotted,
    Note(.A, .half).dotted,
    Note(.F),
    Note(.F, .eighth),
    Note(.E, .eighth),
    Note(.E, .eighth),
    Note(.D, .eighth),
    Note(.D, .eighth),
    Note(.C, .half),
    Note(nil, .eighth),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.E).dotted,
    Note(.G),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.C, .eighth),
    Note(.E).dotted,
    Note(.G, .half).dotted,
    Note(.C).octave(1),
    Note(.D, .eighth).octave(1),
    Note(.C, .eighth).octave(1),
    Note(.A, .eighth).sharp,
    Note(.A, .eighth),
    Note(.G, .eighth),
    Note(.F, .half),
    Note(nil, .eighth),
    ]
  
  override func setup() {
//: Here I've made 3 different experiments, keep scrolling to try all of them by yourself:
    let cucarachaSequence = NoteSequencer(notes: cucaracha)
    cucarachaSequence.beatsPerMinute = 160
    let tipsyCucaracha = ToneGrapher(mode: .floute)
    tipsyCucaracha.loopLenght = cucarachaSequence.calculatedLength
    tipsyCucaracha.function = { (time) -> Double? in
      return cucarachaSequence.pitch(atTime: time)?.advanced(by: time.sine(amplitude: 2, frequency: 20))
    }
    let splittedCucaracha = ToneGrapher(mode: .synth)
    splittedCucaracha.loopLenght = cucarachaSequence.calculatedLength
    splittedCucaracha.function = { (time) -> Double? in
      if time.sine(amplitude: 1, frequency: 50) > 0 {
        return nil
      }
      return cucarachaSequence.pitch(atTime: time)
    }
    let reverseCucaracha = ToneGrapher(mode: .sax)
    let cucarachaLenght = cucarachaSequence.calculatedLength
    reverseCucaracha.loopLenght = cucarachaLenght
    reverseCucaracha.function = { (time) -> Double? in
      return cucarachaSequence.pitch(atTime: cucarachaLenght-time)
    }
    
//: - Experiment:
//: Comment/Uncomment the lines below to see the different experiments I've made.
    self.add(toneGrapher: tipsyCucaracha)
    //self.add(toneGrapher: splittedCucaracha)
    //self.add(toneGrapher: reverseCucaracha)

//: Now is time you go crazy too!!
//: And If you wanna go even more crazy, why not selecting me for a **WWDC 2017 Scholarship**! ... What?? Who said that? 🤔
    
//: Thank You!
  }
}

import PlaygroundSupport
import SpriteKit
let rect = NSRect(x: 0, y: 0, width: 500, height: 600)
let view = SKView(frame: rect)
let scene = GetCrazy(size: rect.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view