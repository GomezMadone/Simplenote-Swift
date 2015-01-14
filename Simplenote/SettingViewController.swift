//
//  SettingViewController.swift
//  Simplenote
//
//  Created by alpha22jp on 2015/01/10.
//  Copyright (c) 2015 alpha22jp@gmail.com. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    let setting = NSUserDefaults.standardUserDefaults()
    let simplenote = Simplenote.sharedInstance
    let database = NoteDatabase.sharedInstance
    let sortItems = ["変更日時（新しい順）", "変更日時（古い順）", "作成日時（新しい順）", "作成日時（古い順）"]

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var sort: UILabel!

    @IBAction func didCancelButtonTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didDoneButtonTap(sender: AnyObject) {
        setting.setObject(email.text, forKey: "email")
        setting.setObject(password.text, forKey: "password")
        simplenote.setAccountInfo(email.text, password: password.text)
        database.deleteAllNotes()

        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let emailSaved = setting.stringForKey("email") {
            email.text = emailSaved
        }
        if let passwordSaved = setting.stringForKey("password") {
            password.text = passwordSaved
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        sort.text = sortItems[setting.integerForKey("sort")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println("segue.identifier: \(segue.identifier)")
        if segue.identifier == "detail" {
            // Navigate to SettingDetail (show (e.g. push))
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let controller = segue.destinationViewController as SettingDetailController
            controller.type = "sort"
            controller.items = sortItems
        }
    }

}
