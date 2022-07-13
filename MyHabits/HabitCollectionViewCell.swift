//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Хмыров on 04.07.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {


    private lazy var indexHabitInArray: Int = {
        var numberHabitInArray = Int()
        return numberHabitInArray
    }()

    private lazy var colorBackgroundViewTrack: UIColor = {
        var colorBackgroundViewTrack = UIColor()
        return colorBackgroundViewTrack
    }()

    private lazy var labelHabitName: UILabel = {
        var labelHabitName = UILabel()
        labelHabitName.translatesAutoresizingMaskIntoConstraints = false
        labelHabitName.numberOfLines = 0
        return labelHabitName
    }()

    private lazy var labelTimeHabit: UILabel = {
        var labelTimeHabit = UILabel()
        labelTimeHabit.translatesAutoresizingMaskIntoConstraints = false
        labelTimeHabit.text = "Каждый день в "
        labelTimeHabit.numberOfLines = 0
        return labelTimeHabit
    }()

    private lazy var labelDateTimeHabit: UILabel = {
        var labelDateTimeHabit = UILabel()
        labelDateTimeHabit.translatesAutoresizingMaskIntoConstraints = false
        labelDateTimeHabit.numberOfLines = 0
        return labelDateTimeHabit
    }()

    private lazy var labelCounter: UILabel = {
        var labelCounter = UILabel()
        labelCounter.translatesAutoresizingMaskIntoConstraints = false
        labelCounter.text = "Счетчик: 0"
        labelCounter.numberOfLines = 0
        return labelCounter
    }()

    private lazy var viewTrack: UIView = {
        var viewTrack = UIView()
        viewTrack.backgroundColor = .white
        viewTrack.translatesAutoresizingMaskIntoConstraints = false
        viewTrack.layer.cornerRadius = 20
        viewTrack.layer.borderWidth = 3
        return viewTrack
    }()

    private lazy var imageCheckMark: UIImageView = {
        var imageCheckMark = UIImageView()
        imageCheckMark.translatesAutoresizingMaskIntoConstraints = false
        imageCheckMark.image = UIImage(systemName: "checkmark")

        imageCheckMark.isHidden = true
        return imageCheckMark
    }()


    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.backgroundColor = .white
        [labelHabitName, labelTimeHabit, labelDateTimeHabit, labelCounter, viewTrack].forEach( { self.addSubview($0) })
        self.viewTrack.addSubview(self.imageCheckMark)
        setupConstrains()
        setupGestureRecogniser()

       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        print(indexHabitInArray)
        print(HabitsStore.shared.todayProgress)
        print(HabitsStore.shared.habits[indexHabitInArray].isAlreadyTakenToday)
    }


    private func setupGestureRecogniser() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(actionGestureRecognizer))
        self.viewTrack.addGestureRecognizer(gestureRecognizer)


    
        
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            self.labelHabitName.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            self.labelHabitName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),

            self.labelTimeHabit.topAnchor.constraint(equalTo: self.labelHabitName.bottomAnchor, constant: 7),
            self.labelTimeHabit.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),

            self.labelDateTimeHabit.leadingAnchor.constraint(equalTo: self.labelTimeHabit.trailingAnchor),
            self.labelDateTimeHabit.centerYAnchor.constraint(equalTo: self.labelTimeHabit.centerYAnchor),
            self.labelDateTimeHabit.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.labelCounter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.labelCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),


            self.viewTrack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            self.viewTrack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.viewTrack.widthAnchor.constraint(equalToConstant: 40),
            self.viewTrack.heightAnchor.constraint(equalToConstant: 40),

            self.imageCheckMark.centerXAnchor.constraint(equalTo: self.viewTrack.centerXAnchor),
            self.imageCheckMark.centerYAnchor.constraint(equalTo: self.viewTrack.centerYAnchor),
            self.imageCheckMark.widthAnchor.constraint(equalToConstant: 25),
            self.imageCheckMark.heightAnchor.constraint(equalToConstant: 25),
        ])
    }


    func setupContent(_ habit: Habit, indexPath: IndexPath ) {
        self.labelHabitName.text = habit.name
        self.labelDateTimeHabit.text = "\(habit.date)"
        self.viewTrack.layer.borderColor = habit.color.cgColor
        self.colorBackgroundViewTrack = habit.color
        self.indexHabitInArray = indexPath.item - 1

        self.labelCounter.text = "Счетчик: \(HabitsStore.shared.habits[indexPath.item - 1].trackDates.count)"

        if HabitsStore.shared.habits[indexPath.item - 1].isAlreadyTakenToday == true {
            self.viewTrack.backgroundColor = habit.color
            self.imageCheckMark.isHidden = false
        }
        else {
            self.imageCheckMark.isHidden = true
            self.viewTrack.backgroundColor = .white
        }
    }



    @objc private func actionGestureRecognizer() {

        if HabitsStore.shared.habits[indexHabitInArray].isAlreadyTakenToday == false {
        HabitsStore.shared.track(HabitsStore.shared.habits[indexHabitInArray])
        }

        self.viewTrack.backgroundColor = colorBackgroundViewTrack
        self.imageCheckMark.isHidden = false


        let habitsViewController = HabitsViewController()
        habitsViewController.reloadCollectionViewHabits()

    }
}


extension HabitCollectionViewCell: nameCollectionCell {
    static var nameCollectionCell: String {
        return String(describing: self)
    }
}
