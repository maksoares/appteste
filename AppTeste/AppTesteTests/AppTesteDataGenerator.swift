//
//  AppTesteDataGenerator.swift
//  AppTesteTests
//
//  Created by marcel.soares on 03/11/20.
//

import Foundation
import SwiftyJSON


class AppTesteDataGenerator {
    
        class func getMovieJson() -> JSON {
        return JSON(parseJSON: """
        {
                "id": "1",
                "title": "ROCKY: UM LUTADOR",
                "date": 218426520,
                "synopsis": "Rocky Balboa, um pequeno boxeador da classe trabalhadora da Filadélfia, é arbitrariamente escolhido para lutar contra o campeão dos pesos pesados, Apollo Creed, quando o adversário do invicto lutador agendado para a luta é ferido. Durante o treinamento com o mal-humorado Mickey Goldmill, Rocky timidamente começa um relacionamento com Adrian, a invisível irmã de Paulie, seu amigo empacotador de carne.",
                "image": "https://limaomecanico.com.br/wp-content/uploads/2019/11/Rocky-Um-Lutador.jpg",
                "time": 218426520,
                "price": 1.99,
                 "people":
                        [
                        {   "id": "1",
                            "name": "Sylvester Stallone\\n(Rocky)",
                            "picture": "https://rollingstone.uol.com.br/media/_versions/sylvester_stallone_como_rocky_foto__metro-goldwyn-mayer_studios_inc___reproducao_via_imdb_widelg.jpg"},
                                
                            {   "id": "2",
                                "name": "Thalia Shire\\n(Adrian)",
                                "picture": "https://media.fstatic.com/Xq4ejBMq9tHiiMTu99VLIc5RUgs=/full-fit-in/290x478/media/artists/avatar/2014/04/talia-shire_a25119_2.jpg"},
                                
                            {   "id": "3",
                                "name": "Burt Young\\n(Paulie)",
                                "picture": "https://totalrocky.com/wp-content/uploads/rocky-paulie-burt-young-meat-house.jpg"}
                            ]
                
            }
        """)
    }

    
}


