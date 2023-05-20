//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Азалия Халилова on 20.05.2023.
//
import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var attachmentView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "image")
        imageView.layer.masksToBounds = true //не отображать те части которые выходят за пределы UIImageView
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.black.cgColor
        
        return textView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Methods
    func set(note: Note) {
        textView.text = note.title + "  " + note.description
        guard let imageData = note.image,
              let image = UIImage(data: imageData) else { return }
        attachmentView.image = image
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        view.backgroundColor = .white
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        
        textView.layer.borderWidth = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0
        
        setupConstraints()
        setImageHeight()
        setupBars()
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-10)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentView.image != nil ? 200 : 0
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    @objc
    private func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    private func setupBars() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                          target: self,
                                          action: #selector(deleteAction))
        setToolbarItems([trashButton], animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
    
    @objc
    private func saveAction() {
        
    }
    
    @objc
    private func deleteAction() {
        
    }
}
