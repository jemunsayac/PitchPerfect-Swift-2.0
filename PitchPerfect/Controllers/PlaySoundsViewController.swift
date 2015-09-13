//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by JM Munsayac on 9/7/15.
//  Project is using X-Code v7.0 beta 6
//  Copyright © 2015 JM Munsayac. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayerNode:AVAudioPlayerNode!
    var audioPitch:AVAudioUnitTimePitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (receivedAudio.filePathUrl != nil) {
            do {
                
                //Instantiate all objects
                audioEngine = AVAudioEngine()
                audioFile = try AVAudioFile(forReading: receivedAudio.filePathUrl)
                audioPlayerNode = AVAudioPlayerNode()
                audioPitch = AVAudioUnitTimePitch()
            
                //Connect audio engine to other nodes
                audioEngine.attachNode(audioPitch)
                audioEngine.attachNode(audioPlayerNode)
                audioEngine.connect(audioPlayerNode, to: audioPitch, format: audioFile.processingFormat)
                audioEngine.connect(audioPitch, to: audioEngine.outputNode, format: audioFile.processingFormat)
                
            }
            catch {
                print("Ooops! something went wrong..")
            }
            
        }
        else {
            print("Error: No file was found!")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudio(-1000)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudio(2000)
    }
    
    @IBAction func playSlowly(sender: UIButton) {
        playAudio(playBackSpeed: 0.5)
    }

    @IBAction func playFast(sender: UIButton) {
        playAudio(playBackSpeed: 2.0)
    }
    
    @IBAction func stopAudioPlay(sender: UIButton) {
        stopAudio()
    }
    
    /*
     * Function Name: playAudio
     * Description: Play audio and control pitch and playback speeds. Playback and pitch are optional and will
     * be set to default values of 1 if not provided
     * 
     * Parameters:
     *      pitch : float number that will control the audio pitch
     *      playBackSpeed : float number that will control the audio play speed
     */
    func playAudio(pitch: float_t = 1.0, playBackSpeed: float_t = 1.0) {
        
        audioPitch.rate = playBackSpeed
        audioPitch.pitch = pitch
        
        do {
            stopAudio() //best practice to stop players before playing another audio
            
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            try audioEngine.start()
            audioPlayerNode.play()
        }
        catch {
            print("Ooops! something went wrong..")
        }
    }
    
    /*
     * Function Name: stopAudio
     * Description: Stop audio player
     *
     * Parameters: No parameters
     */
    func stopAudio(){
        audioPlayerNode.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
