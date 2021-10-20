# frozen_string_literal: true

require_relative 'pokemon'
require_relative 'combat'
require_relative 'fetch_pokemon'

# Clase que maneja el torneo
class Tournament
  attr_accessor :bracket_top8, :bracket_top4, :bracket_finalists

  def initialize(participants, pokemon_types, type_table_numbers, view)
    @bracket_top8 = participants
    @bracket_top4 = []
    @bracket_finalists = []
    @combat = Combat.new(pokemon_types, type_table_numbers)
    @view = view
  end

  # Ejecuta el primer round de la competencia, entre los 8 mejores. Pelean el primero
  # Con el segundo, luego el 3ero con el 4to y asi
  def first_round
    @view.tournament_bracket(@bracket_top8)
    (0..3).each do |i|
      combat_winner = @combat.pokemon_combat(@bracket_top8[2 * i], @bracket_top8[2 * i + 1])
      @view.put_winner(combat_winner)
      @bracket_top4.push(combat_winner)
    end

    # Se ejecuta automaticamente la segunda ronda al terminar
    second_round
  end

  def second_round
    @view.semifinals(@bracket_top4)
    (0..1).each do |i|
      combat_winner = @combat.pokemon_combat(@bracket_top4[2 * i], @bracket_top4[2 * i + 1])
      @view.put_winner(combat_winner)
      @bracket_finalists.push(combat_winner)
    end
    final
  end

  def final
    @view.final(@bracket_finalists)
    winner = @combat.pokemon_combat(@bracket_finalists[0], @bracket_finalists[1])
    @view.champion(winner)
  end
end
