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

class ShareViewController: SLComposeServiceViewController {
    
    let userDefaultsKey = "LinksUserDefaultsKey"
    
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
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
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
    
    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
}
