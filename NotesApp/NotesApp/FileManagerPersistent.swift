//
//  FileManagerPersistent.swift
//  NotesApp
//
//  Created by Азалия Халилова on 30.05.2023.
//

import UIKit

final class FileManagerPersistent {
    
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appending(path: name)
        
        do {
            try data?.write(to: url)
            print("Image was saved")
            return url
        } catch {
            print("Saving image error: \(error)")
            return nil
        }
    }
    
    static func read(from url: URL) -> UIImage? {
        return UIImage(contentsOfFile: url.path)
    }
    
    static func delete(from url: URL) {
        do {
           try FileManager.default.removeItem(at: url)
        } catch {
            print("Delete image error: \(error)")
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)[0]
    }
}
