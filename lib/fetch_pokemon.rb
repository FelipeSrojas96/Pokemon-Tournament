# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'
require_relative 'pokemon'

# retorna el body de la request de un pokemon de acuerdo a su numero en la pokedex
def get_random_pokemon(number)
  uri = URI("https://pokeapi.co/api/v2/pokemon/#{number}")
  res = Net::HTTP.get_response(uri)
  JSON.parse(res.body)
end

# retorna el nombre de un pokemon
def get_name(pokemon)
  pokemon['species']['name']
end

# retorna un hash con los tipos del pokemon,type_1 y type_2
def get_types(pokemon)
  pokemon_types = {}
  case pokemon['types'].size
  when 1
    pokemon_types[:type1] = pokemon['types'][0]['type']['name']
  when 2
    pokemon_types[:type1] = pokemon['types'][0]['type']['name']
    pokemon_types[:type2] = pokemon['types'][1]['type']['name']
  end
  pokemon_types
end

# retorna un hash con las estadisticas del pokemon
def get_stats(pokemon)
  pokemon_stats = {}
  pokemon_stats[:hp] = pokemon['stats'][0]['base_stat']
  pokemon_stats[:attack] = pokemon['stats'][1]['base_stat']
  pokemon_stats[:defense] = pokemon['stats'][2]['base_stat']
  pokemon_stats[:special_attack] = pokemon['stats'][3]['base_stat']
  pokemon_stats[:special_defense] = pokemon['stats'][4]['base_stat']
  pokemon_stats[:speed] = pokemon['stats'][5]['base_stat']
  pokemon_stats
end

# retorna los 8 pokemon participantes del torneo, escogidos de forma aleatoria
def generate_participants
  participants_list = []
  (1..8).each do |_i|
    pokemon = get_random_pokemon(rand(1..151))
    pokemon_participant = Pokemon.new(get_name(pokemon), get_types(pokemon), get_stats(pokemon))
    participants_list.push(pokemon_participant)
  end
  participants_list
end
