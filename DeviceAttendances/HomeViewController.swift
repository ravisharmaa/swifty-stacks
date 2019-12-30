import UIKit

class HomeViewController: UIViewController {
    
    lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        searchButton.setTitle("Get my location", for: .normal)
        searchButton.addTarget(self, action: #selector(deviceSearchAction), for: .touchUpInside)
        return searchButton
        
    }()
    
    lazy var emailTextField: UITextField = {
        let emailField = UITextField()
        emailField.delegate = self
        emailField.font = UIFont.systemFont(ofSize: 15)
        emailField.borderStyle = UITextField.BorderStyle.roundedRect
        emailField.autocorrectionType = UITextAutocorrectionType.no
        emailField.placeholder = "Please Input Your Email"
        return emailField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        title = "Fetch Devices"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(stackView)
        setupStackViewForEmailAndButton()
        
    }
    
    
    
    @objc func deviceSearchAction(sender: UIButton) {
        
        guard let emailText = emailTextField.text, emailText != "" else {
            return
        }
        let viewController = ViewController()
        
        viewController.emailField = emailText
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func setupStackViewForEmailAndButton() {
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}


extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

