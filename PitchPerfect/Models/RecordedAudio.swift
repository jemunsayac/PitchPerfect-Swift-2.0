//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by JM Munsayac on 9/11/15.
//  Copyright © 2015 JM Munsayac. All rights reserved.
//

import Foundation

public class RecordedAudio: NSObject {
    
    public init(filePathUrl: NSURL!, title: String!) {
        
        if(filePathUrl != nil) {
            self.filePathUrl = filePathUrl
        }
    
        if(title != nil) {
            self.title = title
        }
    }
    
    var filePathUrl: NSURL!
    var title: String!
}