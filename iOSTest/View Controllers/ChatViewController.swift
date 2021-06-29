//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    
    ///the view model that calls uses the Backend funcs
    private var chatViewModel = ChatViewModel()
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [Message]?
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    
    ///everytime the chats get set reload the table
    var allChats = [[AnyHashable:Any]](){
        didSet {
            DispatchQueue.main.async {
                self.chatTable.reloadData()
            }
        }
    }
    
    var failsafeURl = URL(string: "https://cdn.aarp.net/content/dam/aarp/entertainment/music/2018/03/1140-concert-ticket-prices.imgcache.rev.web.1140.655.jpg")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///set all the tableviw stuff
        configureTable(tableView: chatTable)
        
        
        ///get all chats
        self.getAllChats()
    }
    
    func getAllChats()  {
        self.chatViewModel.getAllChats(completionHandler: { chats in
            self.allChats = chats!
        })
    }
    
    
    
    
    
    
    
    // MARK: - TableView Functions
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        
        
        ///load the image and set all the data
        let imageURL = URL(string: allChats[indexPath.row]["avatar_url"] as! String) ?? failsafeURl
        cell?.setCellData(message: allChats[indexPath.row])
        cell?.avatarImage.load(url: imageURL!)
        cell?.avatarImage.layer.cornerRadius =  (cell?.avatarImage.frame.size.width)! / 2
        
        
        ///add border and set layer size
        cell?.body.sizeToFit()
        cell?.bubble.frame = (cell?.bubble.frame.insetBy(dx: -1, dy: -1))!
        cell?.bubble.layer.borderWidth = 0.5
      
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChats.count
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    
    
    
    
    // MARK: - IBAction - Back Button
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
}
