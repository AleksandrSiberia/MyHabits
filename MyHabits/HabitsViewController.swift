//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 30.06.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var buttonAddHabit: UIButton = {
        var buttonAddHabit = UIButton()
        buttonAddHabit.translatesAutoresizingMaskIntoConstraints = false
        buttonAddHabit.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonAddHabit.addTarget(self, action: #selector(actionButtonAddHabit), for: .touchUpInside )
        return buttonAddHabit
    }()

    private lazy var flowLayoutCollectionViewHabits: UICollectionViewFlowLayout = {
        var flowLayoutCollectionViewHabits = UICollectionViewFlowLayout()
        flowLayoutCollectionViewHabits.minimumInteritemSpacing = 4
        flowLayoutCollectionViewHabits.sectionInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        flowLayoutCollectionViewHabits.scrollDirection = .vertical
        return flowLayoutCollectionViewHabits
    }()

    private lazy var collectionViewHabits: UICollectionView = {
        var collectionViewHabits = UICollectionView(frame: .zero, collectionViewLayout: flowLayoutCollectionViewHabits)
        collectionViewHabits.translatesAutoresizingMaskIntoConstraints = false
        collectionViewHabits.delegate = self
        collectionViewHabits.dataSource = self
        collectionViewHabits.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.nameCollectionCell)
        collectionViewHabits.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.nameCollectionCell)
        collectionViewHabits.backgroundColor = .yellow
        return collectionViewHabits
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        [buttonAddHabit, collectionViewHabits].forEach({ self.view.addSubview($0) })
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(HabitsStore.shared.todayProgress)
        print(HabitsStore.shared.habits)
    }

    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.buttonAddHabit.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.buttonAddHabit.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),
            self.buttonAddHabit.widthAnchor.constraint(equalToConstant: 40),
            self.buttonAddHabit.heightAnchor.constraint(equalToConstant: 40),

            self.collectionViewHabits.topAnchor.constraint(equalTo: self.buttonAddHabit.bottomAnchor, constant: 14),
            self.collectionViewHabits.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionViewHabits.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionViewHabits.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }


    @objc private func actionButtonAddHabit() {

        let navHabitViewController = UINavigationController(rootViewController: HabitViewController())

        self.navigationController?.present(navHabitViewController, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row != 0 else {
        let cell = collectionViewHabits.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.nameCollectionCell, for: indexPath)
        cell.layer.cornerRadius = 10
        return cell
        }

        let cell = collectionViewHabits.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.nameCollectionCell, for: indexPath) as! HabitCollectionViewCell
        cell.layer.cornerRadius = 10

        cell.setupContent(HabitsStore.shared.habits[indexPath.row - 1])
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width

        let widthItem = screenWidth - flowLayoutCollectionViewHabits.sectionInset.left - flowLayoutCollectionViewHabits.sectionInset.right

        guard indexPath.row != 0 else {
            return CGSize(width: widthItem, height: 77)
        }
        return CGSize(width: widthItem, height: 200)
    }


}




