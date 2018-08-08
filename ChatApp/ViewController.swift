//
//  ViewController.swift
//  ChatApp
//
//  Created by Halil Özel on 6.08.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // başlangıç için bazı elemanları gizleme
        
        // attach button gizleme
        inputToolbar.contentView.leftBarButtonItem = nil
    
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // chat arayüzü tanımlandı.
        senderId = "1"
        senderDisplayName = "Halil Ozel"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count // mesaj değeri kadar dön
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item] // herbir hücredeki değeri döndürür.
    }

    
    // mesajların renklerini ayarlama kısmı
    
    // lazy :  sadece kullanıldığı zaman çalıştırılacak
    
    // giden mesaj renk ayarı
    lazy var outgoingBubble : JSQMessagesBubbleImage = {
        
        return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    
    // gelen mesaj renk ayarı
    lazy var incomingBubble : JSQMessagesBubbleImage = {
        
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    
    // mesajın gönderilme biçimi ayarlanıyor.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
        
        // a ? b : c ternary
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return nil
    }
    
    
    // gönderici ismi gönderi ayarı
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        
        return messages[indexPath.item].senderId == senderId ? 0 : 20
    }
    
    
    // gönder butonuna basınca yapılacak işlemler
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
//        let ref = Constants.dbRef.childByAutoId() // uniq id olusturma
//        
//        let message = ["senderId":senderId,"senderName":senderDisplayName,"mesaj":text]
//        ref.setValue(message)
        
        finishSendingMessage()
        
    }
   
}

