import Foundation
import UIKit
import DailymotionPlayerSDK

@IBDesignable
class DailymotionPlayerView: UIView {
    
    private var playerView: DMPlayerView?
    
    private var playerContainer = UIView()
    
    private var currentDailymotionId = ""
    
    func loadVideo(withId id: String, shouldMute: Bool = false, playerDelegate: DMPlayerDelegate, videoDelegate: DMVideoDelegate, adDelegate: DMAdDelegate) {
        let playerParams = DMPlayerParameters(mute: shouldMute)
        
        if currentDailymotionId != id {
            currentDailymotionId = id
            Dailymotion.createPlayer(playerId: getPlayerId(),
                                     videoId: id,
                                     playerParameters: playerParams,
                                     playerDelegate: playerDelegate,
                                     videoDelegate: videoDelegate,
                                     adDelegate: adDelegate) { [self] createdPlayerView, error in
                
                if let playerView = createdPlayerView {
                    // Add the Player View to view hierarchy
                    self.addPlayerView(playerView: playerView)
                }
                
                if let error = error {
                    print("Debug print: Error creating player", error)
                }
            }
        }
    }
    
    private func addPlayerView(playerView: DMPlayerView) {
        self.playerView = playerView
        // Add the DMPlayerView as a subview to player container
        self.playerContainer.addSubview(playerView)
        
        // Set the playerView's translatesAutoresizingMaskIntoConstraints property to false
        playerView.translatesAutoresizingMaskIntoConstraints = false
        self.playerContainer.frame = self.bounds
        
        // Create constrains in order to keep the playerView flexible and adapt to layout changes
        let constraints = [
            playerView.topAnchor.constraint(equalTo: self.playerContainer.topAnchor, constant: 0),
            playerView.bottomAnchor.constraint(equalTo: self.playerContainer.bottomAnchor, constant: 0),
            playerView.leadingAnchor.constraint(equalTo: self.playerContainer.leadingAnchor, constant: 0),
            playerView.trailingAnchor.constraint(equalTo: self.playerContainer.trailingAnchor, constant: 0)
        ]
        // Activate created constraints
        NSLayoutConstraint.activate(constraints)

        self.addSubview(self.playerContainer)
        // To show custom controls, otherwise video would cover the controls
        self.sendSubviewToBack(self.playerContainer)
    }
    
    private func getPlayerId() -> String {
        return "xniif"
    }
    
    func play() {
        self.playerView?.play()
    }
    
    func pause() {
        self.playerView?.pause()
    }
    
    func seekPlayer(to time: Double) {
        self.playerView?.seek(to: time)
    }
    
    func mute() {
        self.playerView?.setMute(mute: true)
    }
    
    func soundOn() {
        self.playerView?.setMute(mute: false)
    }
    
    func stopPlayer() {
        self.playerView?.pause()
        self.playerContainer.removeFromSuperview()
        self.playerView = nil
        self.currentDailymotionId = ""
    }
    
    func setFullscreen(fullscreen: Bool, orientation: DMPlayerFullscreenOrientation) {
        self.playerView?.setFullscreen(fullscreen: fullscreen, orientation: orientation)
    }
    
    func notifyFullscreenChanged() {
        self.playerView?.notifyFullscreenChanged()
    }
}
