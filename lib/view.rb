# frozen_string_literal: true

# Esta clase sirve como vista para los distintos eventos que ocurren en la competencia
class View
  def initialize; end

  # Muestra el bracket inicial
  def tournament_bracket(bracket8)
    puts 'Bienvenidos a los cuartos de final!'
    puts "Primer combate: #{bracket8[0].name} vs #{bracket8[1].name}"
    puts "Segundo combate: #{bracket8[2].name} vs #{bracket8[3].name}"
    puts "Tercer combate: #{bracket8[4].name} vs #{bracket8[5].name}"
    puts "Cuarto combate: #{bracket8[6].name} vs #{bracket8[7].name}"
  end

  # Imprime el ganador de la pelea
  def put_winner(winner_pokemon)
    puts "El ganador del combate es #{winner_pokemon.name}"
  end

  # Imprime los semifinalistas
  def semifinals(bracket4)
    puts 'Comienzan las semifinales'
    puts "Primer combate: #{bracket4[0].name} vs #{bracket4[1].name}"
    puts "Segundo combate: #{bracket4[2].name} vs #{bracket4[3].name}"
  end

  # Imprime los finalistas
  def final(finalists)
    puts 'Bienvenido a la gran final'
    puts "La final la disputaran: #{finalists[0].name} vs #{finalists[1].name}"
  end

  # Imprime el campeon
  def champion(pokemon)
    puts "El ganador de la competencia es #{pokemon.name}"
  end
end
