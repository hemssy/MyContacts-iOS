import UIKit
import SnapKit
import CoreData

class PhoneBookViewController: UIViewController {
    
    var existingContact: ContactEntity?
    
    private let profileImageView = UIImageView()
    private let randomButton = UIButton(type: .system)
    private let nameField = UITextField()
    private let phoneField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // 네비게이션바
        title = "연락처 추가"
        let applyButton = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(applyTapped))
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

        // 서브뷰
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
        
        if let contact = existingContact {
            if let data = contact.imageData {
                profileImageView.image = UIImage(data: data)
            }
            nameField.text = contact.name
            phoneField.text = contact.phone
            title = contact.name ?? "연락처"
        }
        
    }

    // 적용버튼(저장->pop)
    @objc private func applyTapped() {
        let name = (nameField.text ?? "").trimmingCharacters(in: .whitespaces)
        let phone = (phoneField.text ?? "").trimmingCharacters(in: .whitespaces)

        guard !name.isEmpty, !phone.isEmpty else {
            showAlert(title: "입력 확인", message: "이름과 전화번호를 모두 입력해주세요.")
            return
        }

        let ctx = CoreDataStack.context
        
             let target: ContactEntity
             if let contact = existingContact {
                 // 기존 엔티티 수정
                 target = contact
             } else {
                 // 새로 생성하기(추가 화면에서 들어온 경우)
                 guard let entityDesc = NSEntityDescription.entity(forEntityName: "ContactEntity", in: ctx) else {
                     showAlert(title: "오류", message: "엔터티를 찾을 수 없습니다.")
                     return
                 }
                 target = ContactEntity(entity: entityDesc, insertInto: ctx)
             }

             // 공통필드 반영해주기
             target.name = name
             target.phone = phone
             if let image = profileImageView.image,
                let data = image.jpegData(compressionQuality: 0.9) {
                 target.imageData = data
             } else {
                 target.imageData = nil
             }

        // 저장
        guard CoreDataStack.saveContextIfNeeded() else {
            showAlert(title: "저장 실패", message: "다시 시도해주세요.")
            return
        }

        // 저장하고 바로 메인으로 돌아옴
        navigationController?.popViewController(animated: true)
    }

    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "확인", style: .default))
        present(ac, animated: true)
    }

    // 랜덤 포켓몬 이미지 -> 프로필에 반영
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

