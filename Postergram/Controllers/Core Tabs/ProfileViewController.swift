//
//  ProfileViewController.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 28.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var  collectionView: UICollectionView?
    
    private var userPosts = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.widthExt - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        //Cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        //Headers
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collectionView?.register(ProfileTabsCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
  
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if section == 0 {
            return 0
        }
//        return userPosts.count()
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
//        cell.configure(with: model)
        cell.configure(debug: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //        let model = userPosts[indexPath.row]
        let vc = PostViewController(model: nil)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            // Trying to find the Footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
           // tabs header
            let tabControllHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                         for: indexPath) as! ProfileTabsCollectionReusableView
            tabControllHeader.delegate = self
            return tabControllHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.widthExt,
                          height: collectionView.heightExt/3)
        }
        //Size of Section Tabs
        return CGSize(width: collectionView.widthExt,
                      height: 50)
    }
    
}

//MARK: - ProfileInfoHeaderCollectionReusableViewDelegate

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to the posts section
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mocData = [UserRelationship]()
        for x in 0..<10 {
            mocData.append(UserRelationship(username: "@joe", name: "Joe Smith", type: x % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mocData)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mocData = [UserRelationship]()
        for x in 0..<10 {
            mocData.append(UserRelationship(username: "@joe", name: "Joe Smith", type: x % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mocData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapeditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        //Reload collection view with data
    }
    
    func didTapTaggedButtonTab() {
        //Reload collection view with data

    }
}
