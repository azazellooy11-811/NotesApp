//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Азалия Халилова on 19.05.2023.
//

import UIKit

class NotesListViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: NotesListViewModelProtocol?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupToolBar()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.register(SimpleNoteTableViewCell.self,
                           forCellReuseIdentifier: "SimpleNoteTableViewCell")
        tableView.register(ImageNoteTableViewCell.self,
                           forCellReuseIdentifier: "ImageNoteTableViewCell")
        tableView.separatorStyle = .none
    }
    
    private func setupToolBar() {
        let addButton = UIBarButtonItem(title: "Add note",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addAction))
        let spacing = UIBarButtonItem(systemItem: .flexibleSpace)
        setToolbarItems([spacing, addButton], animated: true)
        navigationController?.isToolbarHidden = false
    }
    
    @objc
    private func addAction() {
        
    }
}

// MARK: - UITableViewDataSource
extension NotesListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let note = viewModel?.sections[indexPath.section].items[indexPath.row]
                as? Note else { return UITableViewCell() }
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleNoteTableViewCell", for: indexPath) as? SimpleNoteTableViewCell {
            
            cell.set(note: note)
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageNoteTableViewCell", for: indexPath) as? ImageNoteTableViewCell {
            
            cell.set(note: note)
            return cell
            
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension NotesListViewController {
    
}
