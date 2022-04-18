//
//  ViewController.swift
//  Core Data Entry -1-
//
//  Created by Ömer Faruk Kılıçaslan on 18.04.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate


class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    var kisilerListe = [Kisiler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //veriKaydi()
//        veriOkuma()
//        //veriSil()
//        //veriOkuma()
//        veriGuncelle()
//        veriOkuma()
//
        
        veriOkuma()
            
        sleep(3)
        
        veriOkumaFiltreleme()
      
        
    }

    func veriKaydi(){
        
        let kisi = Kisiler(context: context)
        kisi.kisi_ad = "berke"
        kisi.kisi_yas = 31
        
        appDelegate.saveContext()
        
        
    }
    
    func veriOkuma(){
        do{
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        }
        catch{
            print("Hata")
        }
        
        for k in kisilerListe{
            print("Ad : \(k.kisi_ad!), Yas : \(k.kisi_yas)")
        }
    }
    
    func veriSil(){
        
        let kisi = kisilerListe[1]
        
        self.context.delete(kisi)
        appDelegate.saveContext()
    }
    
    func veriGuncelle(){
        let kisi = kisilerListe[0]
        kisi.kisi_ad = "YeniAhmet"
        kisi.kisi_yas = 99
        appDelegate.saveContext()
    }
    
    func veriOkumaSiralama(){
        
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        let sort = NSSortDescriptor(key: #keyPath(Kisiler.kisi_yas), ascending: true)

        fetchRequest.sortDescriptors = [sort]
        
        do{
            kisilerListe = try context.fetch(fetchRequest)
        }
        catch{
            print("Hata")
        }
        
        for k in kisilerListe{
            print("Ad : \(k.kisi_ad!), Yas : \(k.kisi_yas)")
        }
    }
    
    func veriOkumaFiltreleme(){
        
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
//
//        //for age
//        fetchRequest.predicate = NSPredicate(format: "kisi_yas > %i", 99)
//        //for multiple asks
//        fetchRequest.predicate = NSPredicate(format: "kisi_ad == %i and kisi_ad == %@", 99,"YeniAhmet")
        //for char ask
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@","e")
        
        
        do{
            kisilerListe = try context.fetch(fetchRequest)
        }
        catch{
            print("Hata")
        }
        
        for k in kisilerListe{
            print("Ad : \(k.kisi_ad!), Yas : \(k.kisi_yas)")
        }
    }
}

