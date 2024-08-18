//
//  ImageExtension.swift
//  TMDBApp
//
//  Created by luis rodriguez on 17/08/24.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
        
        func loadImage(from url: String, placeholder: UIImage? = UIImage(systemName: "photo.badge.arrow.down.fill")) {
            // Establece la imagen predeterminada antes de iniciar la descarga
            self.image = placeholder
            
            // Revisa si la imagen ya está en caché
            if let cachedImage = imageCache.object(forKey: url as NSString) {
                self.image = cachedImage
                return
            }
            
            // Realiza la descarga de la imagen en un hilo secundario
            DispatchQueue.global().async { [weak self] in
                guard let self = self, let url = URL(string: url) else { return }
                
                if let data = try? Data(contentsOf: url), let downloadedImage = UIImage(data: data) {
                    // Almacena la imagen en la caché
                    imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                    
                    // Actualiza la imagen en la UI en el hilo principal
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                    }
                } else {
                    // Si no se pudo descargar la imagen, muestra la imagen predeterminada
                    DispatchQueue.main.async {
                        self.image = placeholder
                    }
                }
            }
        }
    }
