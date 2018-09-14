//
//  ViewController.swift
//  VideoTest
//
//  Created by Frank on 2018/9/14.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit
import AVFoundation

//Q1: UIButton VS Any 差別?

class ViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var screenButton: UIButton!
    
    @IBOutlet weak var noVideoLabel: UILabel!
    
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false
    
    var originFrame: CGRect =  CGRect(x: 0, y: 0, width: 0, height: 0)
    //let rect  = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    let playButtonImage = #imageLiteral(resourceName: "btn_play").withRenderingMode(.alwaysTemplate)
    let pauseButtonImage = #imageLiteral(resourceName: "btn_stop").withRenderingMode(.alwaysTemplate)
    let forwardButtonImage = #imageLiteral(resourceName: "btn_play_forward").withRenderingMode(.alwaysTemplate)
    let backwardButtonImage = #imageLiteral(resourceName: "btn_play_rewind").withRenderingMode(.alwaysTemplate)
    let volumeButtonImage = #imageLiteral(resourceName: "btn_volume_up").withRenderingMode(.alwaysTemplate)
    let muteVolumeButtonImage = #imageLiteral(resourceName: "btn_volume_off").withRenderingMode(.alwaysTemplate)
    let fullScreenButtonImage = #imageLiteral(resourceName: "btn_fullScreen").withRenderingMode(.alwaysTemplate)
    let smallScreenButtonImage = #imageLiteral(resourceName: "btn_fullScreen_exit").withRenderingMode(.alwaysTemplate)
    
    @IBOutlet weak var urlTextInput: UITextField!
    
    @IBAction func searchButtonClick(_ sender: UIButton) {
        
        guard let urlInput = urlTextInput.text else { return }
        
        let videoUrl = URL(string: urlInput)
        
        player = AVPlayer(url: videoUrl!)

        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        playerLayer.frame = videoView.bounds
        
        originFrame = videoView.bounds
        
        videoView.layer.addSublayer(playerLayer)
        
        //player.play()
        
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        addTimeObserver()
        
        noVideoLabel.isHidden = true
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigationUI()
        
        //let videoUrl = URL(string: urlTextInput.text!)
        
        //timeSlider.thumbTintColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        //timeSlider.maximumTrackTintColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        
        
        timeSlider.minimumTrackTintColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        
        //let videoUrl = URL(string: "https://s3-ap-northeast-1.amazonaws.com/mid-exam/Video/taeyeon.mp4")
        
        //player = AVPlayer(url: videoUrl!)
        
        //監測時間 OK
//        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
//        addTimeObserver()
        
        
        //        For AVPlayer:
        //
        //        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        //        let player = AVPlayer(url: videoURL!)
        //        let playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = self.view.bounds
        //        self.view.layer.addSublayer(playerLayer)
        //        player.play()
        
        //以下是可以的
//        playerLayer = AVPlayerLayer(player: player)
//        playerLayer.videoGravity = .resize
//        playerLayer.frame = videoView.bounds
//        videoView.layer.addSublayer(playerLayer)
//        player.play()
        
        
    }
    
    func setControlButtonColor(color: UIColor) {
        playButton.tintColor = color
        backwardButton.tintColor = color
        forwardButton.tintColor = color
        screenButton.tintColor = color
        volumeButton.tintColor = color
    }
    
    func setTimeLabelColor(color: UIColor) {
        
        currentTimeLabel.tintColor = color
        durationLabel.tintColor = color
        
    }
    
    @IBAction func playBtnClick(_ sender: UIButton) {
        
        if isVideoPlaying == true {
            player.pause()
            playButton.setImage(playButtonImage, for: .normal)
        } else {
            player.play()
            playButton.setImage(pauseButtonImage, for: .normal)
        }
        isVideoPlaying = !isVideoPlaying
        
        //暫時測試用
        //顯示目前時間及全部時間
        //setLabel()
        
        //調整方向
        //setupNavigationUI()
        
    }
    
    @IBAction func voiceBtnClick(_ sender: UIButton) {
        
        if player.isMuted {
            player.isMuted = false
            volumeButton.setImage(volumeButtonImage, for: .normal)
        } else {
            player.isMuted = true
            volumeButton.setImage(muteVolumeButtonImage, for: .normal)
        }
        
    }
    
    
    @IBAction func forwardBtnClick(_ sender: UIButton) {
     
        /*
        
        //var currentTime = player.currentTime().value
        
        //var currentTime = player.currentTime
        let currentTime = CMTimeGetSeconds(player.currentTime())
        
        let newTime = currentTime + 10
        
        let targetTime : CMTime = CMTimeMake(Int64(newTime*1000),1000)
        
        //let targetTime : CMTime = CMTimeMake(Int64(newTime*1000),1000)
        
        player.seek(to: targetTime)
        
        */
        
        let currentTime2 = player.currentTime()
        let timeToAdd   = CMTimeMakeWithSeconds(10,1)
        let resultTime = CMTimeAdd(currentTime2, timeToAdd)
        
        player.seek(to: resultTime)
        
//        CMTime currentTime = music.currentTime;
//        CMTime timeToAdd   = CMTimeMakeWithSeconds(5,1);
//
//        CMTime resultTime  = CMTimeAdd(currentTime,timeToAdd);
        
        //then hopefully
//        [music seekToTime:resultTime];
        

        
    }
    
    @IBAction func backwardBtnClick(_ sender: UIButton) {
        
        let currentTime = player.currentTime()
        let timeToSub   = CMTimeMakeWithSeconds(10,1)
        let resultTime = CMTimeSubtract(currentTime, timeToSub)
        
        player.seek(to: resultTime)
        
      //  https://www.mathsisfun.com/definitions/minuend.html
    
    }
    
    //不能拉到目前時間
    @IBAction func sliderTimeChanged(_ sender: UISlider) {
        
            player.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
        
    }
    
    @IBAction func fullScreenPressed(_ sender: Any) {
        if UIDevice.current.orientation.isPortrait {
            
            AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)
            
            //SetOrientation.setLandscape()
            //UIViewController.attemptRotationToDeviceOrientation()
            
            screenButton.setImage(smallScreenButtonImage, for: .normal)
            
            setControlButtonColor(color: UIColor.white)
            setTimeLabelColor(color: UIColor.white)
            
            
        } else {
            
            AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
            
            screenButton.setImage(fullScreenButtonImage, for: .normal)
            
            setControlButtonColor(color: UIColor.black)
            setTimeLabelColor(color: UIColor.black)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabel() {
        
        //self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
        
       // currentTimeLabel.text = String(player.currentItem!.currentTime())
       
        currentTimeLabel.text = getTimeCMTToString(from: player.currentItem!.currentTime())
        durationLabel.text = getTimeCMTToString(from: (player.currentItem?.duration)!)
        
    }
    
    
    //https://stackoverflow.com/questions/42947215/swift-3-play-video-in-fullscreen-when-rotated-to-landscape
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if (UIDevice.current.orientation.isLandscape) {
            
            DispatchQueue.main.async {
                
//                self.view.didAddSubview(self.controllsContainerView)
//                self.layer = AVPlayerLayer(player: self.player!)
//                self.layer?.frame = self.view.frame
//                self.layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//                self.view.layer.addSublayer(self.layer!)
                
                //下斷點會進去跑 .white
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.setControlButtonColor(color: UIColor.white)
                self.setTimeLabelColor(color: UIColor.white)
                
                self.playerLayer.frame = self.videoView.bounds
                
            }
            print("Device is landscape")
        }
        
        else{
            print("Device is portrait")
            
//            movie.view.frame = videoContainerView.bounds
//            controllsContainerView.frame = videoContainerView.bounds
//            self.layer?.removeFromSuperlayer()
            
            navigationController?.setNavigationBarHidden(false, animated: false)
            setControlButtonColor(color: UIColor.black)
            setTimeLabelColor(color: UIColor.black)
            
            //self.playerLayer.frame = self.videoView.bounds
             self.playerLayer.frame = originFrame
            
        }

        
    }
    
    func addTimeObserver() {
        
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player.currentItem else {return}
            self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(currentItem.currentTime().seconds)
            self?.currentTimeLabel.text = self?.getTimeCMTToString(from: currentItem.currentTime())
        })
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLabel.text = getTimeCMTToString(from: player.currentItem!.duration)
        }
    }
    
    func getTimeCMTToString(from time: CMTime) -> String {
        
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    
    }
    
    //https://stackoverflow.com/questions/10654750/converting-cmtime-to-human-readable-time-in-objective-c
    //https://recalll.co/app/?q=iphone%20-%20UISlider%20sticking%20at%20the%20second%20time%20-%20Stack%20Overflow
//    func getTimeString(from duration:Double) -> String{
//
//        let hours   = Int(duration / 3600)
//        let minutes = Int(duration / 60) % 60
//        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
//        if hours > 0 {
//            return String(format: "%:%02i:%02i", arguments: [hours,minutes,seconds])
//        }else {
//            return String(format: "%02i:%02i", arguments: [minutes,seconds])
//        }
//
//    }
    
//    extension CMTime {
//        var durationText:String {
//            let totalSeconds = CMTimeGetSeconds(self)
//            let hours:Int = Int(totalSeconds / 3600)
//            let minutes:Int = Int(totalSeconds % 3600 / 60)
//            let seconds:Int = Int(totalSeconds % 60)
//
//            if hours > 0 {
//                return String(format: "%i:%02i:%02i", hours, minutes, seconds)
//            } else {
//                return String(format: "%02i:%02i", minutes, seconds)
//            }
//        }
//    }


    
    func setupNavigationUI() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        //UIDevice.current.orientation.isLandscape 橫向
        
                if UIDevice.current.orientation.isLandscape {
                    
                    navigationController?.setNavigationBarHidden(true, animated: false)
                    setControlButtonColor(color: UIColor.white)
                    setTimeLabelColor(color: UIColor.white)
                
                } else {
                    
                    navigationController?.setNavigationBarHidden(false, animated: false)
                    setControlButtonColor(color: UIColor.black)
                    setTimeLabelColor(color: UIColor.black)
                
        }
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        playerLayer.frame = videoView.bounds
//    }
    
}

//extension AVPlayerLayer {
//
//}

//https://stackoverrun.com/cn/q/11862327

//extension CGAffineTransform {
//
//    static let ninetyDegreeRotation = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))
//}


extension CGAffineTransform {
    
    static let ninetyDegreeRotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
}

extension AVPlayerLayer {
    
    var fullScreenAnimationDuration: TimeInterval {
        return 0.15
    }
    
    func minimizeToFrame(_ frame: CGRect) {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.identity)
            self.frame = frame
        }
    }
    
    func goFullscreen() {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.ninetyDegreeRotation)
            self.frame = UIScreen.main.bounds
        }
    }
}
