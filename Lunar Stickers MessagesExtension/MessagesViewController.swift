//
//  MessagesViewController.swift
//  Lunar Stickers MessagesExtension
//
//  Created by Mani on 27/07/2023.
//

import Messages
import UIKit

class MessagesViewController: MSMessagesAppViewController {
    @IBOutlet var ShareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        ShareButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Conversation Handling

    override func willBecomeActive(with _: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.

        // Use this method to configure the extension and restore previously stored state.
    }

    override func didResignActive(with _: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.

        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }

    override func didReceive(_: MSMessage, conversation _: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.

        // Use this method to trigger UI updates in response to the message.
    }

    override func didStartSending(_: MSMessage, conversation _: MSConversation) {
        // Called when the user taps the send button.
    }

    override func didCancelSending(_: MSMessage, conversation _: MSConversation) {
        // Called when the user deletes the message without sending it.

        // Use this to clean up state related to the deleted message.
    }

    override func willTransition(to _: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.

        // Use this method to prepare for the change in presentation style.
    }

    override func didTransition(to _: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.

        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
}

extension MessagesViewController {
    func createImageForMessage() -> UIImage? {
        // Load the image from the app's bundle (make sure yourImage.png is added to your project)
        let imageName = "LunarShareScreenshot"
        guard let image = UIImage(named: imageName) else {
            return nil
        }

        // Create the background view with the desired size and translucent background
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 1384, height: 1469))
        backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.5) // Translucent background

        // Create the image view and set its image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit // Adjust the content mode as needed
        imageView.frame = backgroundView.bounds
        backgroundView.addSubview(imageView)

        // Render the background view and its content to an image
        UIGraphicsBeginImageContextWithOptions(backgroundView.frame.size, false, UIScreen.main.scale)
        backgroundView.drawHierarchy(in: backgroundView.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return img
    }

    func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension MessagesViewController {
    @IBAction func btnCreateImageAction(_: UIButton!) {
        if let img = createImageForMessage(), let conversation = activeConversation {
            let layout = MSMessageTemplateLayout()
            layout.image = img
            layout.caption = "Lunar for Lemmy"

            let message = MSMessage()
            message.layout = layout
            // TODO: Change this URL to app store URL when published
            message.url = URL(string: "https://github.com/mani-sh-reddy/Lunar-Lemmy-iOS")
            conversation.insert(message, completionHandler: { error in
                print("IMESSAGE VIEW CONTROLLER ERROR: \(String(describing: error))")
            })
        }
    }
}
