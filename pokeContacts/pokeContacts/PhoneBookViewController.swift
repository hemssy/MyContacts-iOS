import UIKit
import SnapKit

final class PhoneBookViewController: UIViewController {

    private let profileImageView = UIImageView()
    private let randomButton = UIButton(type: .system)
    private let nameField = UITextField()
    private let phoneField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "연락처 추가"

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 75
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.image = nil

        randomButton.setTitle("랜덤 이미지 생성", for: .normal)

        nameField.placeholder = "이름"
        nameField.borderStyle = .roundedRect

        phoneField.placeholder = "전화번호"
        phoneField.keyboardType = .numberPad
        phoneField.borderStyle = .roundedRect

        [profileImageView, randomButton, nameField, phoneField].forEach { view.addSubview($0) }


        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        nameField.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(nameField)
            make.height.equalTo(44)
        }
    }
}

