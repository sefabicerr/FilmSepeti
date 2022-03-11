//
//  MoviesViewController.swift
//  FilmSepeti
//
//  Created by Muhammed Sefa Biçer on 17.02.2022.
//

import UIKit

class MoviesViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    //MARK: Vars
    var moviesList = [Filmler]()
    var category: Kategoriler?
    let tasarim :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        hucreTasarim()

        if let k = category{
            if let kId = Int(k.kategori_id!){
                
                navigationItem.title = k.kategori_ad
                filmlerByKategoriID(kategori_id: kId)
            }
        }
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moviesToDetail"{
            let indeks = sender as? Int
            let VC = segue.destination as! MovieDetailViewController
            VC.movie = moviesList[indeks!]
        }
    }
    
//MARK: Kategoriye göre film çek
    
    func filmlerByKategoriID(kategori_id:Int){
        
        var request = URLRequest(url: URL(string: "\(kCATEGORYBYIDLINK)")!)
        request.httpMethod = "POST"
        let postString = "kategori_id=\(kategori_id)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if error != nil || data == nil{
                print("Hata")
                return
            }
            do{
                
                let cevap = try JSONDecoder().decode(FilmCevap.self, from: data!)
                if let gelenFilmListesi = cevap.filmler{
                    self.moviesList = gelenFilmListesi
                }
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    

//MARK: CollectionViewCell tasarım
    
    private func hucreTasarim(){
        
        let genislik = self.movieCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let hucreGenislik = (genislik-30)/2
        
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        movieCollectionView.collectionViewLayout = tasarim
    }
}



extension MoviesViewController: UICollectionViewDelegate,UICollectionViewDataSource, MoviesCellCollectionViewProtocol{
    
    func sepeteEkle(indexpath: IndexPath) {
        
        print("Sepete eklenen film: \(moviesList[indexpath.row].film_ad!)")
        //navigationController?.popViewController(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let film = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
        cell.movieNameLabel.text = film.film_ad
        cell.moviePriceLabel.text = "14.99"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film.film_resim!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.movieImageView.image = UIImage(data: data!)
                }
            }
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moviesToDetail", sender: indexPath.row)
    }
}
