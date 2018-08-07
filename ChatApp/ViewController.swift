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
    
    lazy var outgoingBubble : JSQMessagesBubbleImage = {
        
        return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    lazy var incomingBubble : JSQMessagesBubbleImage = {
        
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    
    // mesajın gönderilme biçimi ayarlanıyor.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        <#code#>
    }
    
   
}

