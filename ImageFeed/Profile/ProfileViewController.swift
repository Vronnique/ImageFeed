import UIKit

final class ProfileViewController: UIViewController {
    private var imageView: UIImageView?
    private var nameLabel: UILabel?
    private var usernameLabel: UILabel?
    private var bioLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageloaded()
        nameLabelLoaded()
        usernameLabelLoaded()
        bioLabelLoaded()
        logoutButtonLoaded()
    }
    
    func profileImageloaded() {
        let profileImage = UIImage(named: "Userpic")
        let imageView = UIImageView(image: profileImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76).isActive = true
        
        self.imageView = imageView
    }
    
    func nameLabelLoaded() {
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        nameLabel.textColor = .white
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.widthAnchor.constraint(equalToConstant: 241).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        if let imageView = self.imageView {
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        }
        
        self.nameLabel = nameLabel
        
    }
    
    func usernameLabelLoaded() {
        let usernameLabel = UILabel()
        usernameLabel.text = "@ekaterina_nov"
        usernameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        usernameLabel.textColor = .gray
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
        
        usernameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        if let nameLabel = self.nameLabel {
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        }
        
        self.usernameLabel = usernameLabel
    }
    
    func bioLabelLoaded() {
        let bioLabel = UILabel()
        bioLabel.text = "Hello, world!"
        bioLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        bioLabel.textColor = .white
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bioLabel)
        
        bioLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        if let usernameLabel = self.usernameLabel {
            bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        }
        
        self.bioLabel = bioLabel
    }
    
    func logoutButtonLoaded() {
        let logoutButton = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: nil,
            action: nil)
        
        logoutButton.tintColor = UIColor(named: "YP Red")
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapLogoutButton()
        }, for: .touchUpInside)
        
        view.addSubview(logoutButton)
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        if let imageView = self.imageView {
            logoutButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        }
    }
    
    func didTapLogoutButton() {
        print("didtap")
    }
}
