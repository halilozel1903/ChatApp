//
//  ViewController.swift
//  ChatApp
//
//  Created by Halil Özel on 6.08.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit

class ViewController: JSQMessagesViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var messages = [JSQMessage]()
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // başlangıç için bazı elemanları gizleme
        
        // attach button gizleme
        //inputToolbar.contentView.leftBarButtonItem = nil
    
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
        
        self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
            
           collectionView.reloadData()
    
        
        finishSendingMessage()
        
    }
    
    // attachment ile ilgili bir şeyler gönderilince çalışacak metod
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        let actionSheet = UIAlertController(title: "Resim Seçme", message: "Lütfen bir resim seçiniz. !!!", preferredStyle: .actionSheet)
        
        
        let resim = UIAlertAction(title: "Resimler", style: .default) { (action) in
            
            self.gorselSec(type: kUTTypeImage)
            
        }
        
        
        let kamera = UIAlertAction(title: "Kameralar", style: .default) { (action) in
            self.gorselSec(type: kUTTypeMovie)
            
        }
        
        let iptal = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        actionSheet.addAction(resim)
        actionSheet.addAction(kamera)
        actionSheet.addAction(iptal)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
   
    func gorselSec(type:NSString){
        
        self.imagePicker.delegate = self
        self.imagePicker.mediaTypes = [type as String]
        self.present(self.imagePicker,animated: true,completion: nil)
        
    }
    
    
    // resmin seçilmesi,seçildikten sonra resim albumünün kapanması , resmin mesaj olarak gözükmesi
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let resim = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            let image = JSQPhotoMediaItem(image: resim)
            
            self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: image))
        } else if let video = info[UIImagePickerControllerMediaURL] as? URL{
            let video = JSQVideoMediaItem(fileURL: video, isReadyToPlay: true)
            
            self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: video))
        }
        
        dismiss(animated: true, completion: nil)
        
        collectionView.reloadData()
    }
    
    
    
    // videonun çalıştırılması için gerekli işlemleri
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let message = messages[indexPath.item]
        
        if message.isMediaMessage{
            if let videoMesaj = message.media as? JSQVideoMediaItem{
                
                let oynatici = AVPlayer(url: videoMesaj.fileURL)
                let oynaticiKontroller = AVPlayerViewController()
                oynaticiKontroller.player = oynatici
                present(oynaticiKontroller,animated: true,completion: nil)
                
            }
        }
    }
    
}

