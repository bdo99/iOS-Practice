//
//  ViewController.swift
//  IT315Project1
//
//  Created by Brian Do on 3/25/22.
//
// “this App is developed as an educational project”
// “certain materials are included under the fair use exemption of the U.S. Copyright Law
//  and have been prepared according to the multimedia fair use guidelines and are restricted from further
//  use”.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    @IBOutlet weak var imgSong: UIImageView!
    
    
    @IBOutlet weak var lblSongTitle: UILabel!
    
    @IBOutlet weak var lblSongArtist: UILabel!
    
    @IBOutlet weak var swFav: UISwitch!
    
    @IBOutlet weak var btnPlayPause: UIButton!
    
    var songsArray = ["Stay A Minute", "Light Switch", "Love Me", "LMLY", "The Feels"]
    
    var PlaylistArray = [song]()
    var globalselected = song()
    var toggleState = 1
    var mySound: AVAudioPlayer!
    
    func populatePlaylistArray(){
        let song1 = song()
        song1.songTitle = "Stay A Minute"
        song1.songArtist = "Pilo"
        song1.songImg = "Stay_A_Minute.jpg"
        song1.songYouTube = "https://www.youtube.com/watch?v=mJVJK2uDIbI"
        song1.mySound = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Stay_A_Minute", ofType: "wav")! ))
        
        PlaylistArray.insert(song1, at:0)
        
        let song2 = song()
        song2.songTitle = "Light Switch"
        song2.songArtist = "Charlie Puth"
        song2.songImg = "Light_Switch.jpg"
        song2.songYouTube = "https://www.youtube.com/watch?v=WFsAon_TWPQ"
        song2.mySound = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Light_Switch", ofType: "wav")! ))
        
        PlaylistArray.append(song2)
        
        let song3 = song()
        song3.songTitle = "Love Me"
        song3.songArtist = "Jonny Koch, Annie Sollange"
        song3.songImg = "Love_Me.jpg"
        song3.songYouTube = "https://www.youtube.com/watch?v=EVoN5LnipXw"
        song3.mySound = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Love_Me", ofType: "wav")! ))
        
        PlaylistArray.append(song3)
        
        let song4 = song()
        song4.songTitle = "LMLY"
        song4.songArtist = "Jackson Wang"
        song4.songImg = "LMLY.jpg"
        song4.songYouTube = "https://www.youtube.com/watch?v=QIMihDOXMpY"
        song4.mySound = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "LMLY", ofType: "wav")! ))
        
        PlaylistArray.append(song4)
        
        let song5 = song()
        song5.songTitle = "The Feels"
        song5.songArtist = "TWICE"
        song5.songImg = "The_Feels.jpg"
        song5.songYouTube = "https://www.youtube.com/watch?v=f5_wn8mexmM"
        song5.mySound = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "The_Feels", ofType: "wav")! ))
        
        PlaylistArray.append(song5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        populatePlaylistArray()
        setLabels()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.width - size
            
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size)
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        })
        
    }

    @IBAction func btnPlayPause(_ sender: Any) {
        let songPlaying = globalselected
        mySound = songPlaying.mySound
        
        if toggleState == 1{
            toggleState = 2
            btnPlayPause.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            mySound?.play()
        }
        else{
            toggleState = 1
            btnPlayPause.setImage(UIImage(systemName: "play.fill"), for: .normal)
            mySound?.stop()
        }
    }
    
    fileprivate func setLabels(){
        let randomSong = PlaylistArray.randomElement()
        globalselected = randomSong!
        
        imgSong.image = UIImage(named: randomSong!.songImg)
        lblSongTitle.text = randomSong?.songTitle
        lblSongArtist.text = randomSong?.songArtist
        imgSong.contentMode = UIView.ContentMode.scaleAspectFill
        imgSong.layer.cornerRadius = 20
        imgSong.clipsToBounds = true
        imgSong.layer.borderWidth = 2
        imgSong.layer.borderColor = UIColor.lightGray.cgColor
        
        let setFav = UserDefaults.standard.string(forKey: "favorite")
        swFav.isOn = (randomSong!.songTitle == setFav)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        mySound?.stop()
        if toggleState == 2{
            toggleState = 1
            btnPlayPause.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        setLabels()
    }
    
    @IBAction func swFavorited(_ sender: Any) {
        if swFav.isOn{
            UserDefaults.standard.set(lblSongTitle.text, forKey: "favorite")
        }
        else{
            UserDefaults.standard.set("", forKey: "favorite")
        }
    }
    
    @IBAction func btnYouTube(_ sender: Any) {
        let browserApp = UIApplication.shared
        let songYouTubeURL = globalselected.songYouTube
        let url = URL(string:songYouTubeURL)
        browserApp.open(url!)
    }
}

