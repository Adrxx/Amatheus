import Foundation
import AVFoundation

/// Shifts the pitch of an `AVAudioFile` in a custom way
class PitchShifter {

  private let engine = AVAudioEngine()
  private let player = AVAudioPlayerNode()
  private let pitchEffect = AVAudioUnitTimePitch()
  private let reverb = AVAudioUnitReverb()
  
  public var muted: Bool = true {
    willSet {
      if newValue == muted {
        if newValue {
          self.player.pause()
        } else {
          self.player.play()
          //self.player.volume = 1.0
        }
      }
    }
  }

  var pitch: Double {
    set {
      self.pitchEffect.pitch = Float(newValue)
    }
    get {
      return Double(self.pitchEffect.pitch)
    }
  }
  
  func start() {
    self.engine.prepare()
    try! self.engine.start()
    //self.player.play()
    
  }
  
  init(audioFile: AVAudioFile) {
    
    let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: UInt32(audioFile.length))
    try! audioFile.read(into:buffer)
    
    self.reverb.loadFactoryPreset(.mediumRoom)
    self.reverb.wetDryMix = 40

    self.engine.attach(self.player)
    self.engine.attach(self.pitchEffect)
    self.engine.attach(self.reverb)

    self.engine.connect(self.player, to: self.pitchEffect, format: buffer.format)
    self.engine.connect(self.pitchEffect, to: self.reverb, format: buffer.format)
    self.engine.connect(self.reverb, to: self.engine.mainMixerNode, format: self.reverb.outputFormat(forBus: 0))
    
    self.player.scheduleBuffer(buffer, at: nil, options: .loops)
    
  }
  
  
}
