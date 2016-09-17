//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Pranav Kasetti on 06/09/2016.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: UIViewController {
    
    let userDefaultsKey = "LinksUserDefaultsKey"
    let userDefaultsKeyTwo = "Links2UserDefaultsKey"
    
    var links2: Array<String> {
        get {
            let userDefaults = NSUserDefaults(suiteName: "group.pranav.kasetti.ShareExtensionDemo")
            if let links = userDefaults?.objectForKey(userDefaultsKeyTwo) as! Array<String>? {
                return links
            }
            
            return []
        }
        set {
            let userDefaults = NSUserDefaults(suiteName: "group.pranav.kasetti.ShareExtensionDemo")
            userDefaults?.setObject(newValue, forKey: userDefaultsKeyTwo)
            userDefaults?.synchronize()
        }
    }
    
    var links: Array<String> {
        get {
            let userDefaults = NSUserDefaults(suiteName: "group.pranav.kasetti.ShareExtensionDemo")
            if let links = userDefaults?.objectForKey(userDefaultsKey) as! Array<String>? {
                return links
            }
            
            return []
        }
        set {
            let userDefaults = NSUserDefaults(suiteName: "group.pranav.kasetti.ShareExtensionDemo")
            userDefaults?.setObject(newValue, forKey: userDefaultsKey)
            userDefaults?.synchronize()
        }
    }
    
    @IBAction func didSelectPost(sender: AnyObject) {
        let contentType = kUTTypeURL as String
        let content = extensionContext!.inputItems.first as! NSExtensionItem
        
        if let attachment = content.attachments?.first {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                attachment.loadItemForTypeIdentifier(contentType, options: nil, completionHandler: { (data, error) in
                    guard error == nil else {
                        print(error)
                        return
                    }
                    
                    let url = data as! NSURL
                    self.links.append(url.absoluteString)
                    self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
                })
            }
        }
    }
    
    @IBAction func didSelectPostVersionTwo(sender: AnyObject) {
        let contentType = kUTTypeURL as String
        let content = extensionContext!.inputItems.first as! NSExtensionItem
        
        if let attachment = content.attachments?.first {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                attachment.loadItemForTypeIdentifier(contentType, options: nil, completionHandler: { (data, error) in
                    guard error == nil else {
                        print(error)
                        return
                    }
                    
                    let url = data as! NSURL
                    self.links2.append(url.absoluteString)
                    self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
                })
            }
        }
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.extensionContext!.completeRequestReturningItems(nil, completionHandler:nil)
        
    }
    
}
