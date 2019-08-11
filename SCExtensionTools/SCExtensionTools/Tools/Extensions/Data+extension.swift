//
//  Data+extension.swift
//  MyFishInfo
//
//  Created by Stephen Cao on 29/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
extension Data{
    func write2FileWith(fileName: String){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileName)
            
            //writing
            do {
                try self.write(to: fileURL)
            }
            catch {/* error handling here */}
        }
    }
}
