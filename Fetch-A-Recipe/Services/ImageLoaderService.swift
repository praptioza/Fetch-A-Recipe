//
//  ImageLoaderService.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/24/25.
//

import Foundation
import UIKit
import SwiftUI

@MainActor

class ImageLoaderService : ObservableObject {
    
    @Published var image : UIImage?
    
    static let cachememory = NSCache<NSString, UIImage>()
    
    func loadImage (from url_string : String) {
        
        let cache_key = NSString(string: url_string)
        
        // if the image is already in cache, return it (show it to the view from the cache memory)
        // optional binding for the case if image is not in cache and returns nil
        if let cached_img = Self.cachememory.object(forKey: cache_key){     // this tries to fetch a cached object (UIImage value of dict) using cace_key (key in cache for that image)
            self.image = cached_img                                         // if image is in cache memory, then this method returns it and is shown to the view using @Published var
            return
        }
        
        // if image is not in cache but in disk, return it (show it to the view)
        // optional binding for the case if image is not in disk and returns nil
        if let disk_img = loadFromDisk(url_string : url_string){
            Self.cachememory.setObject(disk_img, forKey: cache_key)         // if image is in the disk, then add it to the cache
            self.image = disk_img                                           // if image is in the disk, then send it to view
            return
        }
        
        // async loading of image from API
        // convert string to URL object, if not exit early
        guard let url = URL(string: url_string) else {
            self.image = nil
            return
        }
        //
        Task {
            do {
                // try and wait for the image data from the url HTTP request
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let downloaded_img = UIImage(data: data) else {
                    self.image = nil
                    return
                }   //check the response type and convert data to image, if both pass return image, else nil
                // if image is downloaded from the internet url then add it to the cache and disk
                Self.cachememory.setObject(downloaded_img, forKey: cache_key)
                saveToDisk(data: data, url_string: url_string)
                self.image = downloaded_img                                 // if image is downloaded, then send it to the view
            }
            catch {
                self.image = nil
            }
        }// end task
        
    } // end of func

    // checks if file exists in the disk, if yes, return
    private func loadFromDisk (url_string : String) -> UIImage? {
        let filename = diskCachePath(for: url_string)
        guard FileManager.default.fileExists(atPath: filename.path),
                let data = try? Data(contentsOf: filename),
                let image = UIImage(data: data) else {
                    return nil
                }
        return image
    } // end of loadFromDisk
    
    // save the new image data to disk
    private func saveToDisk (data: Data, url_string : String) {
        let path = diskCachePath(for: url_string)
        try? data.write(to: path)
    } // end of saveToDisk
    
    //
    private func diskCachePath (for url_string : String) -> URL {
        let hashed = url_string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? UUID().uuidString
        let filename = "\(hashed).img"
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(filename)
    } // end of diskCachePath
} // end of class



