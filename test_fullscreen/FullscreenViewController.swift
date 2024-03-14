import UIKit
import DailymotionPlayerSDK

class FullscreenViewController: UIViewController {
    
    @IBOutlet private weak var dailymotionPlayerView: DailymotionPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailymotionPlayerView.loadVideo(withId: "x84sh87", playerDelegate: self, videoDelegate: self, adDelegate: self)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func orientationDidChange() {
            let orientation = UIDevice.current.orientation
            
            switch orientation {
            case .landscapeLeft:
                print("Landscape left")
                self.dailymotionPlayerView.setFullscreen(fullscreen: true, orientation: .landscapeLeft)
                self.dailymotionPlayerView.notifyFullscreenChanged()
            case .landscapeRight:
                print("Landscape right")
                self.dailymotionPlayerView.setFullscreen(fullscreen: true, orientation: .landscapeRight)
                self.dailymotionPlayerView.notifyFullscreenChanged()
            case .portrait:
                print("Portrait")
                self.dailymotionPlayerView.setFullscreen(fullscreen: true, orientation: .portrait)
                self.dailymotionPlayerView.notifyFullscreenChanged()
            case .portraitUpsideDown:
                print("Portrait upside down")
            case .faceDown:
                print("Face down")
            case .faceUp:
                print("Face up")
            case .unknown:
                print("Unknown orientation")
            @unknown default:
                fatalError("New orientation type added that's not handled. Please update the code.")
            }
        }
}

extension FullscreenViewController: DMPlayerDelegate {
    
    func player(_ player: DMPlayerView, openUrl url: URL) {
        UIApplication.shared.open(url)
    }
    
    func playerWillPresentFullscreenViewController(_ player: DMPlayerView) -> UIViewController? {
        return nil
    }
    
    func playerDidRequestFullscreen(_ player: DMPlayerView) {
        // Move the player in fullscreen State
        // Call notifyFullscreenChanged() the player will update his state
        player.notifyFullscreenChanged()
     }
       
     func playerDidExitFullScreen(_ player: DMPlayerView) {
        // Move the player in initial State
        // Call notifyFullscreenChanged() the player will update his state
        player.notifyFullscreenChanged()
     }
    
    func playerWillPresentAdInParentViewController(_ player: DailymotionPlayerSDK.DMPlayerView) -> UIViewController {
        return self
    }
}

extension FullscreenViewController: DMVideoDelegate { }

extension FullscreenViewController: DMAdDelegate { }

