//
//  NoteViewModel.swift
//  NotesApp
//
//  Created by Азалия Халилова on 27.05.2023.
//

import UIKit

protocol NoteViewModelProtocol {
    var text: String { get }
    var image: UIImage? { get }
    
    func save(with text: String, and image: UIImage?, imageName: String?)
    func delete()
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    var text: String {
        let text = (note?.title ?? "") + "\n\n" + (note?.description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var image: UIImage? {
        guard let imageUrl = note?.imageUrl else { return nil }
        return FileManagerPersistent.read(from: imageUrl)
    }
    
    init(note: Note?) {
        self.note = note
    }
    
    // MARK: - Methods
    func save(with text: String, and image: UIImage?, imageName: String?) {
        var url: URL? = note?.imageUrl
        
        if let image, let imageName {
            url = FileManagerPersistent.save(image, with: imageName)
        }
        
        let date = note?.date ?? Date()
        let (title, description) = createTitleAndDescription(from: text)
        
        let note = Note(title: title,
                        description: description,
                        date: date,
                        imageUrl: url)
        NotePersistent.save(note)
    }
    
    func delete() {
        guard let note = note else { return }
        
        if let url = note.imageUrl {
            FileManagerPersistent.delete(from: url)
        }
        
        NotePersistent.delete(note)
    }
    
    // MARK: - Methods
    private func createTitleAndDescription(from text: String) -> (String, String?) {
        var description = text
        
        guard let index = description.firstIndex(where: { $0 == "." ||
            $0 == "!" ||
            $0 == "?" ||
            $0 == "\n" })
        else {
            return (text, nil)
        }
        let title = String(description[...index])
        description.removeSubrange(...index)
        
        return (title, description)
    }
}
