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
  }
  
  init() {
    
    let audiFileURL = Bundle.main.url(forResource:"c", withExtension: "mp3")!
    let audioFile = try! AVAudioFile(forReading: audiFileURL)
    let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: UInt32(audioFile.length))
    try! audioFile.read(into:buffer)
    
    //buffer.floatChannelData?.pointee
    
    
    //    buffer = AVAudioPCMBuffer(pcmFormat: player.outputFormat(forBus: 0), frameCapacity: 100)
    //    buffer.frameLength = 100
    //
    //    // generate sine wave
    //    let sr:Float = Float(mixer.outputFormat(forBus: 0).sampleRate)
    //    let n_channels = mixer.outputFormat(forBus: 0).channelCount
    //
    //    var i = 0
    //    while i < Int(buffer.frameLength) {
    //      let val = sinf(441.0*Float(i)*2*Float(M_PI)/sr)
    //
    //      buffer.floatChannelData?.pointee[i] = val * 0.5
    //      i+=Int(n_channels)
    //    }
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
