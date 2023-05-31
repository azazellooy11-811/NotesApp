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
        //imageView.image = UIImage(named: "image")
        imageView.layer.masksToBounds = true //не отображать те части которые выходят за пределы UIImageView
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.black.cgColor
        textView.delegate = self
        
        return textView
    }()
    
    // MARK: - Properties
    var viewModel: NoteViewModelProtocol?
    private let imageHeight = 200
    private var imageName: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configure()
        navigationItem.rightBarButtonItem?.isEnabled = false
        if textView.text.isEmpty {
            toolbarItems?.first?.isEnabled = false
        }
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private Methods
    private func configure() {
        textView.text = viewModel?.text
        attachmentView.image = viewModel?.image
        print("\(attachmentView.image)")
    }
    
    @objc
    private func saveAction() {
        viewModel?.save(with: textView.text, and: attachmentView.image, imageName: imageName)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func deleteAction() {
        viewModel?.delete()
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
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
        setupBars()
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            let height = attachmentView.image != nil ? imageHeight : 0
            make.height.equalTo(height)
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-10)
        }
    }
    
    private func updateImageHeight() {
        attachmentView.snp.updateConstraints { make in
            make.height.equalTo(imageHeight)
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
        let photoButton = UIBarButtonItem(barButtonSystemItem: .camera,
                                          target: self,
                                          action: #selector(addImage))
        let space = UIBarButtonItem(systemItem: .flexibleSpace)
        setToolbarItems([trashButton, space, photoButton, space], animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
}

extension NoteViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
           navigationItem.rightBarButtonItem?.isEnabled = true
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate
extension NoteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //когда пользователь уже выбрал фотографию
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage,
        let url = info[.imageURL] as? URL else { return }
        
        imageName = url.lastPathComponent
        
        attachmentView.image = selectedImage
        updateImageHeight()
        dismiss(animated: true)
        dismiss(animated: true)
    }
    //отменит выбор фото
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
