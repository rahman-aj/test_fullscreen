import UIKit
import DailymotionPlayerSDK

class ViewController: UIViewController {
    
    @IBOutlet private weak var dailymotionPlayerView: DailymotionPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailymotionPlayerView.loadVideo(withId: "x84sh87", playerDelegate: self, videoDelegate: self, adDelegate: self)
    }
    
    @IBAction private func fullscreenButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "FullscreenViewController", bundle: nil)
        let fullscreenViewController = storyboard.instantiateViewController(withIdentifier: "FullscreenViewController") as! FullscreenViewController
        fullscreenViewController.modalPresentationStyle = .fullScreen
        self.present(fullscreenViewController, animated: true)
    }
}

extension ViewController: DMPlayerDelegate {
    
    func player(_ player: DMPlayerView, openUrl url: URL) {
        UIApplication.shared.open(url)
    }
    
    func playerWillPresentFullscreenViewController(_ player: DMPlayerView) -> UIViewController? {
        print("Debug print: present fullscreen")
        return nil
    }
    
    func playerDidRequestFullscreen(_ player: DMPlayerView) {
        // Move the player in fullscreen State
        // Call notifyFullscreenChanged() the player will update his state
        print("Debug print: didrequest fullscreen")
        player.notifyFullscreenChanged()
    }
    
    func playerDidExitFullScreen(_ player: DMPlayerView) {
        // Move the player in initial State
        // Call notifyFullscreenChanged() the player will update his state
        print("Debug print: didexit fullscreen")
        player.notifyFullscreenChanged()
    }
    
    func playerWillPresentAdInParentViewController(_ player: DailymotionPlayerSDK.DMPlayerView) -> UIViewController {
        return self
    }
}

extension ViewController: DMVideoDelegate { }

extension ViewController: DMAdDelegate { }

