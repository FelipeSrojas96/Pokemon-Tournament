# frozen_string_literal: true

# Clase que modela un pokemon con sus atributos
class Pokemon
  attr_accessor :name, :types, :base_stats

  def initialize(pokemon_name, types, base_stats)
    @name = pokemon_name
    @types = types
    @base_stats = base_stats
  end
end
