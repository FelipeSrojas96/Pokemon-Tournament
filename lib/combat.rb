# frozen_string_literal: true

require_relative 'pokemon'
require_relative 'fetch_pokemon'

# Clase que entrega la logica del combate.
class Combat
  def initialize(pokemon_types, type_table_numbers)
    @pokemon_types = pokemon_types
    @type_table_numbers = type_table_numbers
  end

  # retorna la mejor estadistica entre ataque normal y especial del pokemon
  def better_attack_stat(pokemon)
    if pokemon.base_stats[:attack] >= pokemon.base_stats[:special_attack]
      ['attack', pokemon.base_stats[:attack]]
    else
      ['special_attack', pokemon.base_stats[:special_attack]]
    end
  end

  # retorna el multiplicador por el cual se beneficia el pokemon atacante si tiene un tipo efectivo
  def type_advantage_calculator(type_attacker, _type_defender)
    attacker_type_index = @pokemon_types.find_index(type_attacker)
    defender_type_index = @pokemon_types.find_index(type_attacker)
    @type_table_numbers[attacker_type_index][defender_type_index]
  end

  # si un pokemon es inmune, es decir el multiplicador anterior es 0, entrega victoria por default al inmune
  def win_by_default(pokemon_atk, pokemon_def)
    if type_advantage_calculator(pokemon_atk.types[:type1], pokemon_def.types[:type1]).zero?
      pokemon_def
    else
      false
    end
  end

  # pokemon 1 ataca al 2, usando su ataque normal o especial, con lo cual pokemon 2 se defiende con
  # la defensa de ese tipo. Usa la ventaja de tipos para hacer daño, el daño es attack/defense
  def pokemon_attack(pokemon1, pokemon2)
    pokemon1_best_attack = better_attack_stat(pokemon1)
    base_dmg = if pokemon1_best_attack[0] == 'attack'
                 pokemon1.base_stats[:attack] / pokemon2.base_stats[:defense].to_f
               else
                 pokemon1.base_stats[:special_attack] / pokemon2.base_stats[:special_defense].to_f
               end
    base_dmg * type_advantage_calculator(pokemon1.types[:type1], pokemon2.types[:type1])
  end

  # define el primero en atacar
  def first_turn(pokemon1, pokemon2)
    if pokemon1.base_stats[:speed] > pokemon2.base_stats[:speed]
      1
    elsif pokemon1.base_stats[:speed] == pokemon2.base_stats[:speed]
      rand(1..2)
    else
      2
    end
  end

  # El combate: Ataca el pokemon mas rapido primero, y pelean hasta que uno se queda
  # sin hp. Retorna el pokemon ganador
  def get_winner_fight(pokemon1, pokemon2)
    current_hp_pokemon1 = pokemon1.base_stats[:hp].to_f
    current_hp_pokemon2 = pokemon2.base_stats[:hp].to_f
    while current_hp_pokemon1 >= 0 && current_hp_pokemon2 >= 0
      case first_turn(pokemon1, pokemon2)
      when 1
        current_hp_pokemon2 -= pokemon_attack(pokemon1, pokemon2)
        current_hp_pokemon1 -= pokemon_attack(pokemon2, pokemon1)
      when 2
        current_hp_pokemon1 -= pokemon_attack(pokemon2, pokemon1)
        current_hp_pokemon2 -= pokemon_attack(pokemon1, pokemon2)
      end
    end
    if current_hp_pokemon1 > current_hp_pokemon2
      pokemon1
    else
      pokemon2
    end
  end

  # Retorna el pokemon ganador del combate
  def pokemon_combat(pokemon1, pokemon2)
    return win_by_default(pokemon1, pokemon2) if win_by_default(pokemon1, pokemon2)

    get_winner_fight(pokemon1, pokemon2)
  end
end
