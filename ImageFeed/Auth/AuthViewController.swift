import UIKit

// MARK: - Protocol

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}

// MARK: - AuthViewController

final class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    
    private let showWebViewSegueIdentifier = "ShowWebView"
    private let oauth2Service = OAuth2Service.shared
    
    weak var delegate: AuthViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else {
                assertionFailure("Failed to prepare for \(showWebViewSegueIdentifier)")
                return
            }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Private Methods
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "NavBackButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "NavBackButton")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YPBlack")
    }
    
    // MARK: - IBActions
    
    @IBAction func loginButtonTapped() {
        performSegue(withIdentifier: showWebViewSegueIdentifier, sender: nil)
    }
    
}

// MARK: - WebViewViewControllerDelegate

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        print("🔑 AuthViewController получил код: \(code) 🔑")
        
        oauth2Service.fetchOAuthToken(code: code) { result in
            switch result {
            case .success:
                print("Авторизация успешна")
                vc.dismiss(animated:true)
                self.delegate?.didAuthenticate(self)
            case .failure(let error):
                print("Ошибка авторизации: \(error.localizedDescription)")
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}
