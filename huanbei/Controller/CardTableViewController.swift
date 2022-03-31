//
//  CardTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit




class CardTableViewController: UITableViewController {
    struct Card: Codable {
        var name = ""
        var number = ""
    }
    
    var cards: [Card] = []

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        if let data = UserDefaults.standard.data(forKey: "cards") {
            do {
                cards = try JSONDecoder().decode([Card].self, from: data)
            } catch  {
                print("解码失败",error)
            }
        }

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCardIdentifier, for: indexPath) as! CardTableViewCell

        cell.nameLabel.text = cards[indexPath.row].name
        cell.numberLabel.text = "**** **** **** \(cards[indexPath.row].number.suffix(4))"
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //左滑删除
        if editingStyle == .delete {
            cards.remove(at: indexPath.row)
            
            //编码
            cardSaveData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }

    
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kCardSegue {
            let vc = segue.destination as! CardViewController
            vc.delegate = self
        }

    }
    
    //保存数据
    func cardSaveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            UserDefaults.standard.set(data, forKey: "cards")
        } catch {
            print("编码错误",error)
        }
    }

    
}

extension CardTableViewController: CardViewControllerDelegate {
    func didAdd(bank: String, number: String) {
        cards.append(Card(name: bank, number: number))
        tableView.insertRows(at: [IndexPath.init(row: cards.count - 1, section: 0)], with: .automatic)
        
        cardSaveData()
        //print(bank, number)
    }
}
