//
//  ViewController.swift
//  FilmSepeti
//
//  Created by Muhammed Sefa Biçer on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var categoryTableView: UITableView!
    
    //MARK: Vars
    var categoryList = [Kategoriler]()
    var basketList = [Filmler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tumKategorilerAl()
    }
    
    
    //MARK: Kategorileri çek
    func tumKategorilerAl(){
        
        let url = URL(string: "\(kCATEGORYLINK)")!
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if error != nil || data == nil{
                print("Hata")
                return
            }
            
            do{
                
                let cevap = try JSONDecoder().decode(KategoriCevap.self, from: data!)
                if let gelenKategoriListesi = cevap.kategoriler{
                    
                    self.categoryList = gelenKategoriListesi
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.categoryTableView.reloadData()
                    
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToMovies"{
            let indeks = sender as? Int
            let VC = segue.destination as! MoviesViewController
            VC.category = categoryList[indeks!]
        }
    }
}
    


extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = categoryList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryNameLabel.text = category.kategori_ad
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "categoryToMovies", sender: indexPath.row)
    }
}

