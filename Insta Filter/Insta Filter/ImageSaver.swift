//
//  ImageSaver.swift
//  Insta Filter
//
//  Created by Nadzeya Shpakouskaya on 29/06/2022.
//

import UIKit
/// don't forget add permission to plist.info
/// Privacy - Photo Library Additions Usage Description - "Your message..."
class ImageSaver: NSObject {
    
    var success:(() -> Void)?
    var failed: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            failed?(error)
        } else {
            success?()
        }
    }
}
