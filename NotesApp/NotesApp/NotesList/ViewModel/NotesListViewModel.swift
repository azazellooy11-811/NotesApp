//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by Азалия Халилова on 20.05.2023.
//

import Foundation

protocol NotesListViewModelProtocol {
    var sections: [TableViewSection] { get }
    var reloadTable: (() -> Void)? { get set }
    
    func getNotes() 
}

final class NotesListViewModel: NotesListViewModelProtocol {
    // MARK: - Properties
    var reloadTable: (() -> Void)?
    
    private(set) var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    
    init() {
        getNotes()
    }
    
    func getNotes() {
        let allNotes = NotePersistent.featchAll()
        sections = []
        
        let groupedObjects = allNotes.reduce(into: [Date: [Note]]()) { result,
            note in
            let date = Calendar.current.startOfDay(for: note.date)
            result[date, default: []].append(note)
        }
        
        let keys = groupedObjects.keys
        
        keys.forEach { key in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            let stringDate = dateFormatter.string(from: key)
            
            sections.append(TableViewSection(title: stringDate ,
                                             items: groupedObjects[key] ?? []))
        }
    }
                            
    
    private func setMocks() {
        let section = TableViewSection(title: "20 May 2023",
                                       items: [Note(title: "Shop list",
                                                    description: "Buy to carrot",
                                                    date: Date(),
                                                    imageUrl: nil)
                                       ])
        self.sections = [section]
    }
}
