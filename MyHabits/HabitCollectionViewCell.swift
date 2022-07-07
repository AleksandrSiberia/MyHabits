//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Хмыров on 04.07.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    private lazy var labelHabitName: UILabel = {
        var labelHabitName = UILabel()
        labelHabitName.translatesAutoresizingMaskIntoConstraints = false
        labelHabitName.numberOfLines = 0

        return labelHabitName
    }()

    private lazy var labelTimeHabit: UILabel = {
        var labelTimeHabit = UILabel()
        labelTimeHabit.translatesAutoresizingMaskIntoConstraints = false
        labelTimeHabit.text = "Каждый день в \(dateTimeHabit) "
        labelTimeHabit.numberOfLines = 0
        return labelTimeHabit
    }()

    private lazy var dateTimeHabit: Date = {
        var dateTimeHabit = Date()
        return dateTimeHabit
    }()

    private lazy var labelCounter: UILabel = {
        var labelCounter = UILabel()
        labelCounter.translatesAutoresizingMaskIntoConstraints = false
        labelCounter.text = "Счетчик: "
        labelCounter.numberOfLines = 0
        return labelCounter
    }()


    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.backgroundColor = .white
        [labelHabitName, labelTimeHabit, labelCounter].forEach({ self.addSubview($0) })
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            self.labelHabitName.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            self.labelHabitName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),

            self.labelTimeHabit.topAnchor.constraint(equalTo: self.labelHabitName.bottomAnchor, constant: 7),
            self.labelTimeHabit.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.labelTimeHabit.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.labelCounter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.labelCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
    }


    func setupContent(_ habit: Habit ) {
        labelHabitName.text = habit.name
        print(habit.name)
        dateTimeHabit = habit.date
    }
}



extension HabitCollectionViewCell: nameCollectionCell {
    static var nameCollectionCell: String {
        return String(describing: self)
    }
}
