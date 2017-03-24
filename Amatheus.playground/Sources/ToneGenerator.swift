import Foundation
import AVFoundation

class ToneGenerator {

  
  private let engine = AVAudioEngine()
  private let player = AVAudioPlayerNode()
  private let pitchEffect = AVAudioUnitTimePitch()
  private let reverb = AVAudioUnitReverb()

  var pitch: Double? {
    set {
      if let newValue = newValue {
        self.player.volume = 1.0
        //if (!self.player.isPlaying) { self.player.play() }
        self.pitchEffect.pitch = Float(newValue)
        //if (self.player.isPlaying) { }
      } else {
        self.player.volume = 0.0
      }
    }
    get {
      return Double(self.pitchEffect.pitch)
    }
  }
  
  func start() {
    self.engine.prepare()
    try! self.engine.start()
    self.player.play()
    self.player.volume = 0.0
  }
  
  init(mode: ToneGrapher.Mode) {
    
    let audioFile = mode.audioFile

    let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: UInt32(audioFile.length))
    try! audioFile.read(into:buffer)
    
    reverb.loadFactoryPreset(.largeHall)
    reverb.wetDryMix = 35

    self.engine.attach(self.player)
    self.engine.attach(self.pitchEffect)
    self.engine.attach(reverb)

    self.engine.connect(self.player, to: pitchEffect, format: buffer.format)
    self.engine.connect(self.pitchEffect, to: reverb, format: buffer.format)
    self.engine.connect(self.reverb, to: self.engine.mainMixerNode, format: reverb.outputFormat(forBus: 0))
    
    self.player.scheduleBuffer(buffer, at: nil, options: .loops)
    
  }
  
  
}
