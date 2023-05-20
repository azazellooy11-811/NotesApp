//
//  SimpleNoteTableViewCell.swift
//  NotesApp
//
//  Created by Азалия Халилова on 19.05.2023.
//

import SnapKit
import UIKit

final class SimpleNoteTableViewCell: UITableViewCell {
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightYellow
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Title text"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    // MARK: - Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(note: Note) {
        titleLabel.text = note.title
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
