//
//  DatesTableViewCell.swift
//  MyHabits
//
//  Created by Александр Хмыров on 12.07.2022.
//

import UIKit

protocol nameTableViewCell: AnyObject {
    static var nameTableViewCell: String { get }
}

class DatesTableViewCell: UITableViewCell {


    private lazy var labelDate: UILabel = {
        var labelDate = UILabel()
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        return labelDate
    }()

    private lazy var imageViewTracked: UIImageView = {
        var imageViewTracked = UIImageView()
        imageViewTracked.translatesAutoresizingMaskIntoConstraints = false
        imageViewTracked.image = UIImage(systemName: "checkmark")
        imageViewTracked.isHidden = true
        return imageViewTracked
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(labelDate)
        self.addSubview(imageViewTracked)
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.labelDate.topAnchor.constraint(equalTo: self.topAnchor),
            self.labelDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.labelDate.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.imageViewTracked.centerYAnchor.constraint(equalTo: self.labelDate.centerYAnchor),
            self.imageViewTracked.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
        ])
    }

    
    func setupDatesTableViewCell(date: Date, number: Int, indexPath: IndexPath) {

        let stringDate = HabitsStore.shared.trackDateString(forIndex: indexPath.item)

        self.labelDate.text = stringDate

        let dateTrackedTrueFalse = HabitsStore.shared.habit(HabitsStore.shared.habits[number], isTrackedIn: date)


        if dateTrackedTrueFalse == true {
            imageViewTracked.isHidden = false
        }

    }

}

extension DatesTableViewCell: nameTableViewCell {
    static var nameTableViewCell: String {
        return String(describing: self)
    }
}



