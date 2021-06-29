//
//  ChatViewModel.swift
//  iOSTest
//
//  Created by Prithiv Dev on 28/06/21.
//

import Foundation
import UIKit

class ChatViewModel : NSObject {
    private var chatClient = ChatClient()
    
    
    
    ///make the API call and send the chats back to the viewcontroller
    func getAllChats(completionHandler: @escaping ([[AnyHashable:Any]]?) -> Void)  {
        
        chatClient.fetchChatData({chats in
            completionHandler(chats)
        }, withError: nil)
    
    }

}
