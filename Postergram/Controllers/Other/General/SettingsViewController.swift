//
//  SettingsViewController.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 28.11.2022.
//

import SafariServices
import UIKit

struct SettingsCellModel {
    let title: String
    let handler: (() -> Void)
}

//Viewcontroller to show User Settings
final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingsCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
            SettingsCellModel(title: "Edit Profile") { [weak self] in
                self?.didtapEditProfile()
            },
            SettingsCellModel(title: "Invite Friends") { [weak self] in
                self?.didtapInviteFriends()
            },
            SettingsCellModel(title: "Save Original Posts") { [weak self] in
                self?.didtapsaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Terms of services") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingsCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingsCellModel(title: "Help / Feddback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Log Out") { [weak self] in
                self?.didtapLogOut()
            }
        ])
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms: urlString = Constants.termsUrl
        case.privacy: urlString = Constants.policyUrl
        case.help: urlString = Constants.helpUrl
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let  vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didtapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didtapInviteFriends() {
        
    }
    
    private func didtapsaveOriginalPosts() {
        
    }

    
    private func didtapsaveHelpFeedback() {
        
    }
    
    private func didtapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you shure, you want to Log Out",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(comletion: { success in
                DispatchQueue.main.async {
                    if success {
                        // Show Log In
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                    else {
                        //Error
                        fatalError("Couldnott Log Out user")
                    }
                }
            })
        }))
        present(actionSheet, animated: true)
    }
}

    
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableview: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
