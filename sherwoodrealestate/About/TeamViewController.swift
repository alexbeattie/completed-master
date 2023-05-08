//
//  TeamViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/12/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
import LBTATools
import SafariServices

    
class TeamViewController: UICollectionViewController, SFSafariViewControllerDelegate {
    
    let cellId = "cellId"
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    let closeButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "trending"), for: .normal)
           button.tintColor = .darkGray
           button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
           return button
       }()
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    @objc func handleMore() {
           settingsLauncher.showSettings()
       }
    var disclaimersModel = [Disclaimer]()
    
    
    func setupNavBarButtons() {
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon-2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = moreButton
        navigationItem.rightBarButtonItem?.tintColor = .black
       }
    
    let layout = UICollectionViewFlowLayout()
    let tosVC = DisclaimerViewController()
    func setupBackBarButton() {
          let barBtn = UIBarButtonItem()
          barBtn.title = " "
          barBtn.tintColor = UIColor.black
          navigationItem.backBarButtonItem = barBtn
      }
    func showControllerForMap(setting: Setting) {
        setupBackBarButton()
        let mapVC = MapOfListings()
        navigationController?.pushViewController(mapVC, animated: true)
        
    }

    func showControllerForWebsite(setting: Setting) {
        setupBackBarButton()
        guard let url = URL(string: "http://sherwoodrealestate.com/") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true)
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func showControllerForHelp(setting: Setting) {
        let layout = UICollectionViewFlowLayout()
        let disc = DisclaimerViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(disc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataSherwood()
        setUpNavBar()
        setupNavBarButtons()
        
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
    }
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }

    func setUpNavBar() {
        let width = view.frame.width
        let titleView = UIView(backgroundColor: .clear)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 80)
        titleView.hstack(logoImageView.withWidth(120))
        navigationItem.titleView = titleView
    }

    var teamResults = [Result]()
    func fetchDataSherwood() {
        Service.shared.fetchSherwood { (results, error) in
            if let error = error {
                print("failed to fetch", error)
            }
            self.teamResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TeamCell
        cell.setTeam = teamResults[indexPath.item]
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamResults.count
    }
}

class TeamCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "33", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let repNameLabel = UILabel(text: "alex", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let jobTitleRemarks = UILabel(text: "alex", font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var setTeam: Result? {
        didSet {
            guard let setTeam = setTeam else { return }
            repNameLabel.text = setTeam.Representative
            titleLabel.text = setTeam.JobTitle
            jobTitleRemarks.text = setTeam.PublicRemarks
            imageView.sd_setImage(with: URL(string: setTeam.imageUrl))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
        stack(imageView, repNameLabel,titleLabel,jobTitleRemarks,separatorView.withHeight(24),UIView(), spacing: 4, alignment: .center, distribution: .equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
}

extension TeamViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 550)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}



