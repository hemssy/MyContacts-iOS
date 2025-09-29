import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {

    private let profileImageView = UIImageView()
    private let randomButton = UIButton(type: .system)
    private let nameField = UITextField()
    private let phoneField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // 네비게이션바 제목,버튼
        title = "연락처 추가"
        let applyButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyTapped))
        navigationItem.rightBarButtonItem = applyButton

        // 프로필 이미지뷰
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 75
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.image = nil

        // 랜덤 버튼
        randomButton.setTitle("랜덤 이미지 생성", for: .normal)
        randomButton.addTarget(self, action: #selector(didTapRandomImage), for: .touchUpInside)

        // 텍스트필드
        nameField.placeholder = "이름"
        nameField.borderStyle = .roundedRect

        phoneField.placeholder = "전화번호"
        phoneField.keyboardType = .numberPad
        phoneField.borderStyle = .roundedRect

        // 서브뷰 추가
        [profileImageView, randomButton, nameField, phoneField].forEach { view.addSubview($0) }

        // 레이아웃
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

    @objc private func applyTapped() {

    }

    // 버튼 → 랜덤 포켓몬 이미지 가져와서 프로필에 반영
    @objc private func didTapRandomImage() {
        randomButton.isEnabled = false
        PokemonAPI.fetchRandomPokemonImage { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                self.profileImageView.image = image
                self.profileImageView.contentMode = .scaleAspectFill
            }
            self.randomButton.isEnabled = true
        }
    }
}

