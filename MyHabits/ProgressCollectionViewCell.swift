//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Хмыров on 04.07.2022.
//

import UIKit

protocol NameCollectionCell: AnyObject  {
    static var nameCollectionCell: String { get }
}

protocol ProgressCollectionViewCellDelegate {
    func notifyNeedNewWidthViewColorProgress()
}


class ProgressCollectionViewCell: UICollectionViewCell {

    private lazy var labelMotivation: UILabel = {
        var labelMotivation = UILabel()
        labelMotivation.translatesAutoresizingMaskIntoConstraints = false
        labelMotivation.text = "Все получится!"
        labelMotivation.font = UIFont(name: "SFProText-Semibold", size: 13)
        labelMotivation.textColor = .systemGray
        labelMotivation.numberOfLines = 0
        return labelMotivation
    }()

    private lazy var labelPrecent: UILabel = {
        var precent = UILabel()
        precent.translatesAutoresizingMaskIntoConstraints = false
        precent.text = "\(round(HabitsStore.shared.todayProgress * 100)) %"
        precent.numberOfLines = 0
        precent.font = UIFont(name: "SFProText-Semibold", size: 13)
        precent.textColor = .systemGray
        return precent
    }()

    private lazy var viewProgress: UIView = {
        var viewProgress = UIView()
        viewProgress.translatesAutoresizingMaskIntoConstraints = false
        viewProgress.backgroundColor = .systemGray2
        viewProgress.layer.cornerRadius = 7
        return viewProgress
    }()

    private lazy var viewColorProgress: UIView = {
        var viewColorProgress = UIView()
        let widthViewProgress = UIScreen.main.bounds.width - 14 - 14 - 14 - 14
        let widthViewColorProgress = widthViewProgress * CGFloat(HabitsStore.shared.todayProgress)
        
        viewColorProgress.backgroundColor = UIColor(named: "Violet")
        viewColorProgress.layer.cornerRadius = 7
        viewColorProgress.frame.size.height = 14
        viewColorProgress.frame.size.width = widthViewColorProgress
        return viewColorProgress
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.backgroundColor = .white
        [labelMotivation, labelPrecent, viewProgress].forEach({ self.addSubview($0) })
        self.viewProgress.addSubview(viewColorProgress)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.labelPrecent.text = "\(round(HabitsStore.shared.todayProgress * 100)) %"
    }


    private func setupConstraints() {

        NSLayoutConstraint.activate([
            self.labelMotivation.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            self.labelMotivation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),

            self.labelPrecent.centerYAnchor.constraint(equalTo: self.labelMotivation.centerYAnchor),
            self.labelPrecent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),

            self.viewProgress.topAnchor.constraint(equalTo: self.labelMotivation.bottomAnchor, constant: 14),
            self.viewProgress.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.viewProgress.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -14),
            self.viewProgress.heightAnchor.constraint(equalToConstant: 14),

            self.viewColorProgress.topAnchor.constraint(equalTo: self.viewProgress.topAnchor),
            self.viewColorProgress.leadingAnchor.constraint(equalTo: self.viewProgress.leadingAnchor),
            self.viewColorProgress.bottomAnchor.constraint(equalTo: self.viewProgress.bottomAnchor),

        ])
    }
}

extension ProgressCollectionViewCell: NameCollectionCell {

    static var nameCollectionCell: String {
        return String(describing: self)
    }
}

extension ProgressCollectionViewCell: ProgressCollectionViewCellDelegate {

    func notifyNeedNewWidthViewColorProgress() {
        let widthViewProgress = UIScreen.main.bounds.width - 14 - 14 - 14 - 14
        let widthViewColorProgress = widthViewProgress * CGFloat(HabitsStore.shared.todayProgress)

        self.viewColorProgress.frame.size.width = widthViewColorProgress

    }
}

