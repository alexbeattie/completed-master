//
//  Disclaimer.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//


import UIKit
import Foundation
import LBTATools


    
class DisclaimerViewController: UICollectionViewController {
    
    var disclaim: DisclaimerModel? {
        didSet {
            
        }
    }
    let cellId = "cellId"
    let headerId = "headerId"
    let myfooterId = "footerId"
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
    let leftRightMargin: CGFloat = 12.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(DisclaimerFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: myfooterId)
        collectionView.register(DisclaimerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(DisclaimerCell.self, forCellWithReuseIdentifier: cellId)
        
        setUpNavBar()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.scrollDirection = .vertical
        }
        fetchDataSherwood()
        collectionView.backgroundColor = .white
        collectionView.reloadData()
        
    }
    
    func setUpNavBar() {
        
        let width = view.frame.width
        let titleView = UIView(backgroundColor: .clear)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 80)
        
        titleView.hstack(logoImageView.withWidth(120))
        navigationItem.titleView = titleView
    }
    
    var disclaimers = [Disclaimer]()
    func fetchDataSherwood() {
        TosService.shared.fetchDisclaimer { (disclaimerResults, error) in
            if let error = error {
                print("failed to fetch", error)
            }
            self.disclaimers = disclaimerResults
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! DisclaimerCell
        cell.dis = disclaimers[indexPath.item]
        cell.jobTitleRemarks.preferredMaxLayoutWidth = collectionView.frame.size.width - 12 - 12
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disclaimers.count
    }
    
    // MARK: Footer & Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! DisclaimerHeader
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: myfooterId, for: indexPath) as! DisclaimerFooter
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}


    
    
class DisclaimerCell: UICollectionViewCell {
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    let titleLabel = UILabel(text: "33", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let repNameLabel = UILabel(text: "alex", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let jobTitleRemarks = UILabel(text: "alex", font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()

    var dis: Disclaimer? {
        didSet {
            guard let dis = dis else { return }
            let tvc = TeamViewController()
            tvc.disclaimersModel.append(dis)
            jobTitleRemarks.text = dis.PublicRemarks
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
        stack(jobTitleRemarks, spacing: 0, alignment: .leading, distribution:.equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
    }
}

extension DisclaimerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

