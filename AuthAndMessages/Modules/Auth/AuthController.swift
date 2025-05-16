//
//  AuthController.swift
//  AuthAndMessages
//
//  Created by Mangust on 15.05.2025.
//

import UIKit
import SnapKit

final class AuthController: UIViewController {
    private var logoImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "photo.artframe")
        v.contentMode = .scaleAspectFill
        return v
    }()
    private lazy var phoneTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.placeholder = "Phone Number"
        return tf
    }()
    private var passwordTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.keyboardType = .numberPad
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    private var phoneUnderlineView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    private var passwordUnderlineView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    private lazy var signInButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign in", for: .normal)
        btn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.layer.masksToBounds = true
        return btn
    }()
    private lazy var tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(handleTap)
    )

    private var phoneFormatter: PhoneMaskFormatter?//(pattern: "+7 XXX XXX-XX-XX")

    private let viewModel: AuthViewModel
    private let infosViewModel = InfosViewModel()
    private let dateFormatterHelper = DateFormatterHelper()

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            if let phoneMask = await viewModel.getPhoneMask() {
                phoneFormatter = PhoneMaskFormatter(pattern: phoneMask)
            }
        }
        setupView()
        configureConstraints()
    }

    private func setupView() {
        view.backgroundColor = .white

        view.addGestureRecognizer(tapGesture)

        view.addSubview(logoImageView)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneUnderlineView)
        view.addSubview(passwordUnderlineView)
        view.addSubview(signInButton)
    }

    private func configureConstraints() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(additionalSafeAreaInsets.top).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalTo(80)
        }

        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(240)
        }

        phoneUnderlineView.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(4)
            $0.centerX.equalTo(phoneTextField)
            $0.width.equalTo(phoneTextField)
            $0.height.equalTo(2)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(phoneUnderlineView.snp_bottomMargin).offset(16)
            $0.leading.equalTo(phoneUnderlineView.snp.leading)
            $0.height.equalTo(40)
            $0.width.equalTo(240)
        }

        passwordUnderlineView.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(4)
            $0.centerX.equalTo(passwordTextField)
            $0.width.equalTo(passwordTextField)
            $0.height.equalTo(2)
        }

        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordUnderlineView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }

    @objc
    func handleTap() {
        view.endEditing(true)
    }

    @objc
    func signIn() {
        guard let phone = phoneTextField.text,
              !phone.isEmpty, let password = passwordTextField.text,
              !password.isEmpty else {
            return
        }

        viewModel.isAuthSuccessfull(phone, password, completion: { [weak self] isSuccess in
            guard let self = self else {
                return
            }

            if isSuccess {
                let controller = InfosViewController(
                    viewModel: self.infosViewModel,
                    dateFormatter: self.dateFormatterHelper
                )
                self.goNext(vc: controller)
            }
        })
    }
}

fileprivate extension AuthController {
    func goNext(vc: UIViewController) {
        Task {
            if let nav = navigationController {
                nav.pushViewController(vc, animated: true)
            } else {
                present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension AuthController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            phoneFormatter?.deleteLast()
        } else {
            phoneFormatter?.input(character: string)
        }
        textField.text = phoneFormatter?.formattedNumber()
        return false
    }
}
