//
//  ImageNoteTableViewCell.swift
//  NotesApp
//
//  Created by Азалия Халилова on 19.05.2023.
//

import UIKit

final class ImageNoteTableViewCell: UITableViewCell {
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightGreen
        
        return view
    }()
    
    private lazy var attachmentView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true //не отображать те части которые выходят за пределы UIImageView
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Main text"
        label.font = .systemFont(ofSize: 14)
        
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
        guard let imageData = note.image,
              let image = UIImage(data: imageData) else { return }
        attachmentView.image = image
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(attachmentView)
        containerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        attachmentView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(5)
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
