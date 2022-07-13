//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 12.07.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    private lazy var indexHabitInArray: Int = {
        var indexHabitInArray = Int()
        return indexHabitInArray
    }()

    private var nameHabit: String?

    private lazy var barButtonRight: UIBarButtonItem = {
        var barButtonRight = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(actionBarButtonRight))
        return barButtonRight
    }()

    private lazy var labelActivity: UILabel = {
        var labelActivity = UILabel()
        labelActivity.translatesAutoresizingMaskIntoConstraints = false
        labelActivity.text = "АКТИВНОСТЬ"
        return labelActivity
    }()


    private lazy var tableViewDate: UITableView = {
        var tableViewDate = UITableView()
        tableViewDate.translatesAutoresizingMaskIntoConstraints = false
        tableViewDate.delegate = self
        tableViewDate.dataSource = self
        tableViewDate.register(DatesTableViewCell.self, forCellReuseIdentifier: DatesTableViewCell.nameTableViewCell)
        tableViewDate.register( UITableViewCell.self, forCellReuseIdentifier: "Default")
        return tableViewDate
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "customGrey" )
        [labelActivity, tableViewDate].forEach({ self.view.addSubview($0) })
        setupConstraints()
        self.navigationItem.rightBarButtonItem = barButtonRight

    }


    func setupHabitDetailsViewController(indexPith: IndexPath) {

        let habit: Habit = HabitsStore.shared.habits[indexPith.row - 1]
        nameHabit = habit.name

        if let name: String = self.nameHabit {
                  self.navigationItem.title = name
              }

        self.indexHabitInArray = indexPith.item - 1
    }

    func setupConstraints() {
        NSLayoutConstraint.activate ([
            self.labelActivity.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14),
            self.labelActivity.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.tableViewDate.topAnchor.constraint(equalTo: self.labelActivity.bottomAnchor, constant: 14),
            self.tableViewDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            self.tableViewDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),
            self.tableViewDate.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -14),
        ])
    }

    @objc func actionBarButtonRight() {
        let habitViewController = HabitViewController()
        let navHabitViewController = UINavigationController(rootViewController: habitViewController)
        self.navigationController?.present(navHabitViewController, animated: true)

        habitViewController.setupHabitViewController(habit: HabitsStore.shared.habits[indexHabitInArray], indexHabit: indexHabitInArray)
    }

}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DatesTableViewCell.nameTableViewCell, for: indexPath) as! DatesTableViewCell

        cell.setupDatesTableViewCell(date: HabitsStore.shared.dates[indexPath.row], number: indexHabitInArray)

        return cell
    }
}