import UIKit
import SnapKit

class ContactCell: UITableViewCell {

    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let phoneLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        profileImageView.layer.borderColor = UIColor.systemGray3.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .secondarySystemBackground

        nameLabel.font = UIFont.systemFont(ofSize: 16)
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = .secondaryLabel
        phoneLabel.textAlignment = .right

        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)

        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        phoneLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(12)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }


    func configure(name: String, phone: String) {
        nameLabel.text = name
        phoneLabel.text = phone
    }


    func configure(with contact: ContactEntity) {
        nameLabel.text = contact.name
        phoneLabel.text = contact.phone
        if let data = contact.imageData, let img = UIImage(data: data) {
            profileImageView.image = img
        } else {
            profileImageView.image = nil
        }
    }
}

