//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by Азалия Халилова on 20.05.2023.
//

import Foundation

protocol NotesListViewModelProtocol {
    var sections: [TableViewSection] { get }
}

final class NotesListViewModel: NotesListViewModelProtocol {
    // MARK: - Properties
    private(set) var sections: [TableViewSection] = []
    
    init() {
        getNotes()
        setMocks()
    }
    
    private func getNotes() {
        
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "20 May 2023",
                                       items: [Note(title: "Shop list",
                                                    description: "Buy to carrot",
                                                    date: Date(),
                                                    imageUrl: nil,
                                                    image: nil)
                                       ])
        self.sections = [section]
    }
}
