//
//  ChatCell.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorBubbleView: UIView!
    @IBOutlet weak var authorChatLabel: UILabel!
    
    var isEncrypted: Bool?
    var isDetected: Bool?
    var speechDelegate: SpeechDelegate?
    var imposterDelegate: ImposterDelegate?
    var viewImposterDelegate: ViewImposterDelegate?
    var chat: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bubbleLongTap = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(sender:)))
        self.bubbleView.addGestureRecognizer(bubbleLongTap)
        self.bubbleView.isUserInteractionEnabled = true
        
        let authorLongTap = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(sender:)))
        self.authorBubbleView.addGestureRecognizer(authorLongTap)
        self.authorBubbleView.isUserInteractionEnabled = true
        
        let bubbleOneTap = UITapGestureRecognizer.init(target: self, action: #selector(oneTap(sender:)))
        self.bubbleView.addGestureRecognizer(bubbleOneTap)
        self.bubbleView.isUserInteractionEnabled = true
        
        let authorBubbleOneTap = UITapGestureRecognizer.init(target: self, action: #selector(oneTap(sender:)))
        self.authorBubbleView.addGestureRecognizer(authorBubbleOneTap)
        self.authorBubbleView.isUserInteractionEnabled = true
        
        let bubbleSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(onSwipe(sender:)))
        bubbleSwipe.direction = .left
        self.contentView.addGestureRecognizer(bubbleSwipe)
        self.contentView.isUserInteractionEnabled = true
        
//        let authorSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(onSwipe(sender:)))
//        authorSwipe.direction = .left
//        self.authorBubbleView.addGestureRecognizer(bubbleSwipe)
//        self.authorBubbleView.isUserInteractionEnabled = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        let textData = Cryptograph.sharedInstance.decryptText(text: self.chat!)
        speechDelegate?.viewPressed(cell: self, didTap: textData)
    }
    
    @objc func oneTap(sender: UITapGestureRecognizer) {
        imposterDelegate?.oneTapped(cell: self)
    }
    
    @objc func onSwipe(sender: UISwipeGestureRecognizer) {
        viewImposterDelegate?.viewImposterNow(cell: self)
    }
    
    func setChatCell(message: PFObject) {
        self.bubbleView.layer.cornerRadius = 16
        self.bubbleView.clipsToBounds = true
        
        self.authorBubbleView.layer.cornerRadius = 26
        self.authorBubbleView.clipsToBounds = true
        
        self.chat = message["Chats"] as? [String]
        
        let composer = message["author"] as! PFUser
        
        if (isDetected!) {
            self.bubbleView.backgroundColor = .orange
            self.authorBubbleView.backgroundColor = .orange
        } else{
            self.bubbleView.backgroundColor = .blue
            self.authorBubbleView.backgroundColor = .blue
        }
        
        if (PFUser.current()?.username == composer.username) {
            self.usernameLabel.alpha = 0
            self.chatLabel.alpha = 0
            self.bubbleView.alpha = 0
            
            self.authorNameLabel.text = composer.username
            
            let chatData = message["Chats"] as? [String]
            if (self.isEncrypted!) {
                self.authorChatLabel.text = Cryptograph.sharedInstance.joinStrings(text: chatData!)
            } else {
                self.authorChatLabel.text = Cryptograph.sharedInstance.decryptText(text: chatData!)
            }
           
            self.authorBubbleView.alpha = 1
            self.authorNameLabel.alpha = 1
            self.authorChatLabel.alpha = 1
            
        } else {
            self.usernameLabel.alpha = 1
            self.chatLabel.alpha = 1
            self.bubbleView.alpha = 1
            
            self.usernameLabel.text = composer.username
            
            let chatData = message["Chats"] as? [String]
            if (self.isEncrypted!) {
                self.chatLabel.text = Cryptograph.sharedInstance.joinStrings(text: chatData!)
            } else {
                self.chatLabel.text = Cryptograph.sharedInstance.decryptText(text: chatData!)
            }
            
            self.authorBubbleView.alpha = 0
            self.authorNameLabel.alpha = 0
            self.authorChatLabel.alpha = 0
        }
    }
}

protocol SpeechDelegate {
    func viewPressed(cell: ChatCell, didTap: String)
}

protocol ImposterDelegate {
    func oneTapped(cell: ChatCell)
}

protocol ViewImposterDelegate {
    func viewImposterNow(cell: ChatCell)
}
